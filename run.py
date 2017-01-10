from freedompop import freedompop
import telegram_bot
import utils
import config

utils.logger.info('Initialising bot...')

# register all fpop handlers
r_h = telegram_bot.telegram_bot.register_handler
# name, desc, func, req
if config.FREEDOMPOP_PASSWORD_USE_ENCRYPTION:
    r_h('credentials', 'specify the passphrase for the GPG key',
        freedompop.set_passphrase, ('passphrase',))
r_h('usage', 'data usage information', freedompop.action_get_usage)
r_h('balance', 'plan balance information', freedompop.action_get_balance)
r_h('readsms', 'read your SMS', freedompop.action_list_sms)
r_h('sendsms', 'send a SMS', freedompop.action_send_sms,
    ('destination', 'text'))
r_h('callhistory', 'call history', freedompop.action_list_calls)
r_h('getsipconfig', 'get your SIP credentials',
    freedompop.action_get_sip_config)
r_h('getcallpref', 'display preferences for incoming calls',
    freedompop.action_get_incoming_call_pref)
r_h('setcallpref', 'set preferences for incoming calls',
    freedompop.action_set_incoming_call_pref, ('use_pv',))
r_h('getaccountinfo', 'display account info',
    freedompop.action_get_phone_account_info)
r_h('getphonemarket', 'display Play Store version',
    freedompop.action_get_phone_market)

telegram_bot.run()
