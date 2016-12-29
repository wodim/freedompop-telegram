import json
import time

import requests

import config
import utils


class FreedomPop(object):
    username = None
    password = None

    access_token = None
    refresh_token = None
    token_expires = 0

    api_base = 'https://api.freedompop.com'
    api_username = None
    api_password = None

    def __init__(self):
        self.username = config.FREEDOMPOP_USER
        self.password = config.FREEDOMPOP_PASSWORD

        self.api_username = config.FREEDOMPOP_API_USER
        self.api_password = config.FREEDOMPOP_API_PASSWORD

    def _update_token(self):
        if time.time() < self.token_expires:
            return  # no new token necessary

        url = self.api_base + '/auth/token'
        auth = config.FREEDOMPOP_API_USER, config.FREEDOMPOP_API_PASSWORD

        if self.refresh_token is None:
            # no refresh_token, this is the first time we log in
            utils.logger.info('Obtaining a completely new access token.')
            params = {'grant_type': 'password',
                      'username': self.username,
                      'password': self.password}
            response = requests.post(url, auth=auth, params=params)
            data = json.loads(response.content.decode('utf8'))
        else:
            # there's a refresh_token, use it to regenerate the access_token
            utils.logger.info('Refreshing the current access token.')
            params = {'grant_type': 'refresh_token',
                      'refresh_token': self.refresh_token}
            response = requests.post(url, auth=auth, params=params)
            data = json.loads(response.content.decode('utf8'))

        self.access_token = data['access_token']
        self.refresh_token = data['refresh_token']
        self.token_expires = time.time() + int(data['expires_in'])

        utils.logger.info('New token obtained successfully.')

    def _make_request(self, endpoint, params=None, method='GET', data=None,
                      files=None):
        if method not in {'GET', 'POST'}:
            raise ValueError('method not supported: %s' % method)
        if method != 'POST' and (data is not None or files is not None):
            raise ValueError('cannot post files/data with method %s' % method)
        if not params:
            params = {}

        self._update_token()

        url = self.api_base + endpoint
        auth = config.FREEDOMPOP_API_USER, config.FREEDOMPOP_API_PASSWORD
        params['accessToken'] = self.access_token
        params['appIdVersion'] = config.FREEDOMPOP_APP_VERSION
        if endpoint == '/phone/device/config':
            params['deviceId'] = config.FREEDOMPOP_DEVICE_ID

        utils.logger.info('Making a %s request to %s...', method, endpoint)

        if method == 'GET':
            response = requests.get(url, params=params, auth=auth)
        elif method == 'POST':
            response = requests.post(url, params=params, auth=auth,
                                     data=data, files=files)
        utils.logger.info(response.content.decode('utf8'))

        utils.logger.info('Request finished.')

        return json.loads(response.content.decode('utf8'))

    def action_get_sip_data(self, **kwargs):
        endpoint = '/phone/device/config'
        response = self._make_request(endpoint)

        msg = 'SIP data information: \n\n'
        msg += 'Username:\n%s\n\n' % response['username']
        msg += 'Password:\n%s\n\n' % response['password']
        msg += 'Server:\n%s\n\n' % response['server']

        return msg

    def action_get_usage(self, **kwargs):
        endpoint = '/user/usage'
        response = self._make_request(endpoint)

        # base_bandwidth = response['baseBandwidth']
        # offer_bonus_earned = response['offerBonusEarned']
        total_limit = response['totalLimit']
        percent_used = response['percentUsed']
        balance_remaining = response['balanceRemaining']
        #
        used = total_limit - balance_remaining

        msg = 'Data plan usage information:\n\n'
        msg += ('You have used %d MB (%.1f%%) out of your plan of %d MB.\n\n' %
                (utils.b_to_mb(used), percent_used,
                 utils.b_to_mb(total_limit)))

        endTime = response['endTime'] / 1000
        timeRemaining = endTime - time.time()
        daysRemaining = timeRemaining / 86400
        hoursRemaining = timeRemaining % 86400 / 3600
        minutesRemaining = timeRemaining % 3600 / 60
        msg += 'Time until quota reset:'
        if daysRemaining > 0:
            msg += ' %d days' % daysRemaining
        if hoursRemaining > 0:
            msg += ' %d hours' % hoursRemaining
        if minutesRemaining > 0:
            msg += ' %d minutes' % minutesRemaining

        return msg

    def action_get_balance(self, **kwargs):
        endpoint = '/phone/balance'
        response = self._make_request(endpoint)

        msg = 'Plan balance information:\n\n'
        for plan in response:
            if plan.get('voicePlanType') != 'MAIN':
                continue

            msg += 'Plan "%s":\n' % plan['name']
            msg += '* Price: %.2f\n' % plan['price']
            if plan.get('unlimitedVoice', False):
                msg += '* Unlimited calls\n'
            else:
                msg += ('* Calls: %d min (%d min remaining)\n' %
                        (utils.s_to_m(plan['baseSeconds']),
                         plan['balance']['remainingMinutes']))
            if plan.get('unlimitedData', False):
                msg += '* Unlimited data\n'
            else:
                msg += ('* Data: %d MB remaining\n' %
                        utils.b_to_mb(plan['balance']['remainingData']))
            if 'baseSMS' in plan:
                msg += ('* SMS: %d (%d remaining)\n' %
                        (plan['baseSMS'], plan['balance']['remainingSMS']))
            msg += '\n'

        return msg

    def action_get_sms(self, **kwargs):
        endpoint = '/phone/listsms'
        response = self._make_request(endpoint)

        msg = 'Reading sms...\n'
        for sms in response['messages']:
            msg += '\n\nFrom: %s\n' % sms['from']
            msg += '%s' % sms['body']
        return msg

    def action_send_sms(self, **kwargs):
        endpoint = '/phone/sendsms'
        destination, text = kwargs['destination'], kwargs['text']
        data = {'to_numbers': destination, 'message_body': text}
        files = {'media_file': (None, 'none')}

        response = self._make_request(endpoint, method='POST', data=data,
                                      files=files)

        if not response.get('groupId'):
            return 'SMS not sent. Check the number and try again.'
        else:
            return 'SMS sent.'


freedompop = FreedomPop()
