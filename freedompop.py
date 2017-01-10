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
    passphrase = None

    access_token = None
    refresh_token = None
    push_token_status = 'unregistered'
    token_expires = 0

    api_base = 'https://api.freedompop.com'
    api_username = None
    api_password = None

    def __init__(self):
        self.username = config.FREEDOMPOP_USER
        self.api_username = config.FREEDOMPOP_API_USER

    def _update_token(self):
        if time.time() < self.token_expires:
            return  # no new token necessary

        url = self.api_base + '/auth/token'
        auth = config.FREEDOMPOP_API_USER, config.FREEDOMPOP_API_PASSWORD

        if self.refresh_token is None:
            if config.FREEDOMPOP_PASSWORD_USE_ENCRYPTION:
                crypter = utils.Crypter()
                self.password = crypter.obtain_password(
                    config.FREEDOMPOP_PASSWORD_GPG_FILE,
                    self.passphrase
                )
                crypter.import_public_key(
                    config.FREEDOMPOP_PASSWORD_PUBLIC_KEY
                )
            else:
                self.password = config.FREEDOMPOP_PASSWORD

            # no refresh_token, this is the first time we log in
            utils.logger.info('Obtaining a completely new access token.')
            params = {'grant_type': 'password',
                      'username': self.username,
                      'password': self.password}
            response = requests.post(url, auth=auth, params=params)
            data = json.loads(response.content.decode('utf8'))
            # The references are no longer in use. Destroy them.
            self.password = None
            self.passphrase = None
        else:
            # there's a refresh_token, use it to regenerate the access_token
            utils.logger.info('Refreshing the current access token.')
            params = {'grant_type': 'refresh_token',
                      'refresh_token': self.refresh_token}
            response = requests.post(url, auth=auth, params=params)
            data = json.loads(response.content.decode('utf8'))

        if 'error' in data:
            raise FreedomPopAPIError(data['error_description'])

        self.access_token = data['access_token']
        self.refresh_token = data['refresh_token']
        self.token_expires = time.time() + int(data['expires_in'])

        utils.logger.info('New token obtained successfully.')

    def _register_push_token(self):
        if self.push_token_status != 'unregistered':
            return
        utils.logger.info('Registering this device...')
        self.push_token_status = 'registering'
        endpoint = '/phone/push/register/token'
        config_params = ('deviceId', 'deviceSid', 'deviceType', 'radioType',
                         'pushToken')
        response = self._make_request(endpoint, config_params=config_params)
        if response['isSuccess']:
            utils.logger.info('Device registered successfully.')
        else:
            utils.logger.info("Couldn't register this device.")
        self.push_token_status = 'registered'

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
        self._register_push_token()

        url = self.api_base + endpoint
        auth = config.FREEDOMPOP_API_USER, config.FREEDOMPOP_API_PASSWORD
        params['accessToken'] = self.access_token
        if 'appIdVersion' in config_params:
            params['appIdVersion'] = config.FREEDOMPOP_APP_VERSION
        if 'deviceId' in config_params:
            params['deviceId'] = config.FREEDOMPOP_DEVICE_ID
        if 'deviceSid' in config_params:
            params['deviceSid'] = config.FREEDOMPOP_DEVICE_SID
        if 'deviceType' in config_params:
            params['deviceType'] = config.FREEDOMPOP_DEVICE_TYPE
        if 'radioType' in config_params:
            params['radioType'] = config.FREEDOMPOP_RADIO_TYPE
        if 'pushToken' in config_params:
            params['pushToken'] = config.FREEDOMPOP_PUSH_TOKEN

        utils.logger.info('Making a %s request to %s with "%s"...',
                          method, endpoint, params)

        if method == 'GET':
            response = requests.get(url, params=params, auth=auth)
        elif method == 'POST' or method == 'PUT':
            response = requests.request(method=method, url=url, params=params,
                                        auth=auth, data=data, files=files)
        utils.logger.info('Response: ' + response.content.decode('utf8'))

        utils.logger.info('Request finished.')

        try:
            ret = json.loads(response.content.decode('utf8'))
        except json.JSONDecodeError:
            raise FreedomPopAPIError('Error decoding JSON response')

        if 'error' in ret:
            msg = 'Error calling the FreedomPop API:\n'
            msg += ret['error_description']
            raise FreedomPopAPIError(msg)

        return ret

    def set_passphrase(self, **kwargs):
        self.passphrase = kwargs['passphrase']
        return 'Ready. The passphrase has been preloaded.'

    def action_get_sip_config(self, **kwargs):
        endpoint = '/phone/device/config'
        config_params = ('deviceId', 'deviceSid', 'radioType')
        response = self._make_request(endpoint, config_params=config_params)

        msg = 'SIP login information:\n\n'
        msg += 'Username:\n    %s\n' % response['username']
        msg += 'Password:\n    %s\n' % response['password']
        msg += 'Server:  \n    %s' % response['server']

        return msg

    def action_get_phone_market(self, **kwargs):
        endpoint = '/phone/market'
        response = self._make_request(endpoint)

        # TODO: requires formatting.

        return 'Not implemented yet.'

    def action_get_phone_account_info(self, **kwargs):
        endpoint = '/phone/account/info'
        response = self._make_request(endpoint)

        msg = 'Account information:\n\n'
        msg += 'First Name: %s\n' % response['firstName']
        msg += 'Last Name: %s\n' % response['lastName']
        msg += 'e-mail: %s\n' % response['email']
        msg += 'Plan: "%s"\n' % response['voiceplan']['name']
        msg += 'Price: %.2f\n' % response['voiceplan']['price']
        if response['voiceplan']['unlimitedVoice']:
            msg += 'Unlimited calls\n'
        else:
            msg += ('Base minutes: %d\n' %
                    utils.s_to_m(response['voiceplan']['baseSeconds']))
        if response['voiceplan']['unlimitedText']:
            msg += 'Unlimited SMS\n'
        else:
            msg += 'Base SMS: %d\n' % response['voiceplan']['baseSMS']
        msg += ('\nDays until billing date: %d\n' %
                response['daysUntilBillingDate'])
        for sim in response['accounts']:
            msg += '\nSIM Id: %s\n' % sim['accountId']
            msg += 'SIM name: %s\n' % sim['accountName']
            msg += 'Phone number: %s\n' % sim['phoneNumber']
        msg += ('\nAccount is %s\n' %
                response['accountStatusAndMessage']['status'])
        msg += '"%s"\n' % response['accountStatusAndMessage']['message']

        return msg

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

    def action_list_sms(self, **kwargs):
        endpoint = '/phone/listsms'
        response = self._make_request(endpoint)

        messages = response['messages']
        if messages:
            msg = 'Received SMS:\n'
            for message in messages:
                msg += '\n\nFrom: %s\n' % message['from']
                msg += '%s' % message['body']
        else:
            msg = "You don't have any SMS."

        return msg

    def action_list_calls(self, **kwargs):
        endpoint = '/phone/calls'
        params = {'startDate': 0, 'endDate': int(time.time()),
                  'includeOutgoing': 1, 'includeIncoming': 1}
        response = self._make_request(endpoint, params=params)

        calls = response['calls']
        if calls:
            msg = 'Received calls:\n'
            for call in response['calls']:
                pass  # TODO
        else:
            msg = "You don't have any calls."

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

        if response['usePV']:
            msg = 'Premium Voice is enabled.'
        else:
            msg = 'Premium Voice is disabled.'

        return msg

    def action_set_incoming_call_pref(self, **kwargs):
        endpoint = '/phone/setincomingcallpref'
        try:
            use_pv = int(kwargs['use_pv']) != 0
        except ValueError:
            raise FreedomPopAPIError('Invalid value for use_pv (0 or 1)')
        params = {'usePV': use_pv}
        response = self._make_request(endpoint, params=params, method='PUT')

        if response['isSuccess']:
            if use_pv:
                msg = 'Premium Voice is now enabled.'
            else:
                msg = 'Premium Voice is now disabled.'
        else:
            raise FreedomPopAPIError('Error setting your call preferences')

        return msg


freedompop = FreedomPop()
