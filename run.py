from freedompop import freedompop
import telegram_bot
import utils

utils.logger.info('Initialising bot...')

# register all fpop handlers
r_h = telegram_bot.telegram_bot.register_handler
# name, desc, func, req
r_h('usage', 'data usage information', freedompop.action_get_usage, 0)
r_h('balance', 'plan balance information', freedompop.action_get_balance, 0)
r_h('readsms', 'read your texts', freedompop.action_get_sms, 0)
r_h('sendsms', 'send texts', freedompop.action_send_sms, 2)

utils.logger.info('Connecting to Telegram...')

telegram_bot.run()
