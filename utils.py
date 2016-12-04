import logging


class Logger(object):
    def __init__(self):
        for i in ('requests', 'urllib3', 'tweepy'):
            logging.getLogger(i).setLevel(logging.WARNING)

        format = ('[{filename:>16}:{lineno:<4} {funcName:>16}()] ' +
                  '{asctime}: {message}')
        logging.basicConfig(format=format, style='{',
                            datefmt='%Y-%m-%d %H:%M:%S', level=logging.INFO)
        self.logger = logging.getLogger('freedompop-telegram')
        self.logger.info('Logger initialised.')

    def get_logger(self):
        return self.logger

logger = Logger().get_logger()


def ellipsis(text, max_length):
    if len(text) > max_length:
        return text[:max_length - 1] + '…'
    else:
        return text


def b_to_mb(b):
    return b // 1024 // 1024


def s_to_m(s):
    return s // 60
