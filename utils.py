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


def zip_args(keys, values):
    """given a list of keys and a list of values where len(values) >= len(keys)
        zips them into a dictionary, merging the last elements of "values" into
        one string if there are too many of them.

        example: zip_args(['name', 'description'],
                          ['submit', 'submits', 'a', 'new', 'post'])
                 => {'name': 'submit', 'description': 'submits a new post'}
    """
    if len(values) < len(keys):
        raise ValueError('not enough values to zip')

    if len(values) > len(keys):
        offset = len(keys) - 1
        values[offset:] = [' '.join(values[offset:])]

    return dict(zip(keys, values))
