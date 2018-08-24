import logging
import re

class Content:
    RAW_TEXT_IDENTIFIER = "RAW TEXT"

    def __init__(self, raw_text):
        self.raw_text = raw_text
        self.tag_char = "\#"

    def __str__(self):
        return RAW_TEXT_IDENTIFIER + self.raw_text

    @property
    def tag_regex(self):
        return '(?<={})'.format(self.tag_char)

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

    def has_tags(self):
        return re.search(self.tag_regex, self.raw_text) is not None

    def parse_tags():
        tag_matches = re.search(self.tag_regex, self.raw_text)
        tags, index = [], 0
        while True:
            try:
                tags.append(tag_matches.group(index))
            except IndexError:
                break

        return tags




