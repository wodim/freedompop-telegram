import json
import time

import requests

import config
import utils


class FreedomPopAPIError(Exception):
    pass


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
                      files=None, config_params=None):
        if method not in {'GET', 'POST', 'PUT'}:
            raise ValueError('method not supported: %s' % method)
        if method != 'POST' and (data is not None or files is not None):
            raise ValueError('cannot post files/data with method %s' % method)
        if not params:
            params = {}
        if not config_params:
            config_params = []

        self._update_token()

        url = self.api_base + endpoint
        auth = config.FREEDOMPOP_API_USER, config.FREEDOMPOP_API_PASSWORD
        params['accessToken'] = self.access_token
        if 'appIdVersion' in config_params:
            params['appIdVersion'] = config.FREEDOMPOP_APP_VERSION
        if 'deviceId' in config_params:
            params['deviceId'] = config.FREEDOMPOP_DEVICE_ID
        if 'deviceSid' in config_params:
            params['deviceSid'] = config.FREEDOMPOP_DEVICE_SID
        if 'radioType' in config_params:
            params['radioType'] = config.FREEDOMPOP_RADIO_TYPE

        utils.logger.info('Making a %s request to %s with "%s"...',
                          method, endpoint, params)

        if method == 'GET':
            response = requests.get(url, params=params, auth=auth)
        elif method == 'POST':
            response = requests.post(url, params=params, auth=auth,
                                     data=data, files=files)
        utils.logger.info('Response: ' + response.content.decode('utf8'))

        utils.logger.info('Request finished.')

        try:
            ret = json.loads(response.content.decode('utf8'))
        except JSONDecodeError:
            raise FreedomPopAPIError('Error decoding JSON response')

        if 'error' in ret:
            msg = 'Error calling the FreedomPop API:\n'
            msg += ret['error_description']
            raise FreedomPopAPIError(msg)

        return ret

    def action_get_sip_config(self, **kwargs):
        endpoint = '/phone/device/config'
        config_params = ('deviceId', 'deviceSid', 'radioType')
        response = self._make_request(endpoint, config_params=config_params)

        msg = 'SIP data information: \n\n'
        msg += 'Username:\n%s\n\n' % response['username']
        msg += 'Password:\n%s\n\n' % response['password']
        msg += 'Server:\n%s\n\n' % response['server']

        return msg

    def action_get_phone_market(self, **kwargs):
        endpoint = '/phone/market'
        response = self._make_request(endpoint)

        # TODO: requires formatting.

        return 'Not implemented yet.'

    def action_get_phone_account_info(self, **kwargs):
        endpoint = '/phone/account/info'
        response = self._make_request(endpoint)

        # TODO: requires formatting.

        return 'Not implemented yet.'

    def action_get_usage(self, **kwargs):
        endpoint = '/user/usage'
        response = self._make_request(endpoint)

        # base_bandwidth = response['baseBandwidth']
        # offer_bonus_earned = response['offerBonusEarned']
        total_limit = response['totalLimit']
        percent_used = response['percentUsed'] * 100
        balance_remaining = response['balanceRemaining']
        #
        used = total_limit - balance_remaining

        msg = 'Data plan usage information:\n\n'
        msg += ('You have used %d MB (%.1f%%) out of your plan of %d MB.\n\n' %
                (utils.b_to_mb(used), percent_used,
                 utils.b_to_mb(total_limit)))

        end_time = response['endTime'] / 1000
        time_remaining = end_time - time.time()
        msg += 'Time until quota reset: '
        msg += utils.format_seconds(time_remaining)

        return msg

    def action_get_balance(self, **kwargs):
        endpoint = '/phone/balance'
        config_params = ('appIdVersion')
        response = self._make_request(endpoint, config_params=config_params)

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
        text = text.encode('iso-8859-15', errors='ignore')
        data = {'to_numbers': destination, 'message_body': text}
        files = {'media_file': (None, 'none')}

        response = self._make_request(endpoint, method='POST', data=data,
                                      files=files)

        if not response.get('groupId'):
            return 'SMS not sent. Check the number and try again.'
        else:
            return 'SMS sent.'

    def action_get_incoming_call_pref(self, **kwargs):
        endpoint = '/phone/getincomingcallpref'
        response = self._make_request(endpoint)

        # I have no idea of what PV is.
        if response['usePV']:
            msg = 'PV is enabled.'
        else:
            msg = 'PV is disabled.'

        return msg


freedompop = FreedomPop()
