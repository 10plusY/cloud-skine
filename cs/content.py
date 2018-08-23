import logging

class Content(object):
    def __init__(self, raw_text):
        self.raw_text = raw_text

    def __str__(self):
        return "RAW: " + self.raw_text

    def __repr__(self):
        return self.__str__()

    def encode_text(self, encoding):
        try:
            self.raw_text = self.raw_text.encode(encoding)
        except LookupError:
            logging.warning('Cannot encode. Encoding %s is not valid.' % encoding)

    def decode_text(self, encoding):
        try:
            self.raw_text = self.raw_text.decode(encoding)
        except LookupError:
            logging.warning('Cannot decode. Encoding %s is not valid.' % encoding)



