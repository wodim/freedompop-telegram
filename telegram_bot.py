import asyncio
from collections import OrderedDict

import telepot
import telepot.aio

import config
import utils


class TelegramBot(telepot.aio.Bot):
    HELP_MESSAGE = 'The following commands are available:\n\n'
    INVALID_CMD = ("I don't know what you mean by that. If you need help, " +
                   'use /help.')
    UNKNOWN_USER = "You are not allowed to use this bot.\nYour user ID is: %d"

    handlers = OrderedDict()

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._answerer = telepot.aio.helper.Answerer(self)

    async def on_chat_message(self, inc_message):
        try:
            content_type, chat_type, chat_id = telepot.glance(inc_message)

            # if it's not text...
            if content_type != 'text':
                await self.send_message(inc_message, self.INVALID_CMD)
                return

            longname = '%s (%s)' % (chat_id, self.format_name(inc_message))
            msg = 'Message from %s: "%s"' % (longname, inc_message['text'])
            utils.logger.info(msg)

            # if this user is not among the allowed ones to use the bot...
            if chat_id not in config.ALLOWED_USERS:
                utils.logger.info('Access denied for user %d.' % chat_id)
                msg = self.UNKNOWN_USER % chat_id
                await self.send_message(inc_message, msg)
                return

            if not inc_message['text'].startswith('/'):
                await self.send_message(inc_message, self.INVALID_CMD)
                return

            # send a "typing..." notification
            await self.sendChatAction(chat_id, 'typing')

            # parse
            params = inc_message['text'][1:].split(' ')
            command, args = params[0], params[1:]
            if command in {'help', 'start'}:
                msg = self.generate_help()
            elif command in self.handlers.keys():
                if len(args) < self.handlers[command]['req']:
                    msg = ('/%s requires at least %d parameters.' %
                           (command, self.handlers[command]['req']))
                else:
                    msg = self.handlers[command]['func'](args)
            else:
                msg = self.INVALID_CMD
            await self.send_message(inc_message, msg, no_preview=True)

        except Exception as e:
            msg = 'Error handling %s: "%s"' % (longname, inc_message['text'])
            utils.logger.exception(msg)
            await self.send_message(inc_message, 'Sorry, try again.')

    async def send_message(self, inc_message, caption, filename=None,
                           no_preview=False):
        """helper function to send messages to users."""
        id_ = inc_message['chat']['id']
        if filename:
            caption = utils.ellipsis(caption, 200)
            with open(filename, 'rb') as f:
                await self.sendPhoto(id_, f, caption=caption)
        else:
            caption = utils.ellipsis(caption, 4096)
            await self.sendMessage(id_, caption,
                                   disable_web_page_preview=no_preview)

    def generate_help(self):
        """generates a help text based on what's registered under
            self.handlers."""
        msg = self.HELP_MESSAGE
        tpl = '/%s: %s\n'
        for name, info in self.handlers.items():
            msg += tpl % (name, info['desc'])
        return msg

    def register_handler(self, name, desc, func, req):
        """registers a new handler"""
        self.handlers[name] = dict(desc=desc, func=func, req=req)

    def format_name(self, message):
        """formats a "from" property into a string"""
        longname = []
        if 'username' in message['from']:
            longname.append('@' + message['from']['username'])
        if 'first_name' in message['from']:
            longname.append(message['from']['first_name'])
        if 'last_name' in message['from']:
            longname.append(message['from']['last_name'])
        return ', '.join(longname)


telegram_bot = TelegramBot(config.TELEGRAM_TOKEN)


def run():
    loop = asyncio.get_event_loop()
    loop.create_task(telegram_bot.message_loop())

    try:
        loop.run_forever()
    finally:
        loop.close()
