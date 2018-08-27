module CloudSkine
  class ContentChecker
    attr_reader :tag_char

    def initialize(tag_char="#")
      @tag_char = tag_char
      @tag_regex = /(?:^|\s)(?:#{Regexp.quote(@tag_char)})([a-zA-Z\d]+)/
    end

    def tag_regex
      /(?:^|\s)(?:#{Regexp.quote(@tag_char)})([a-zA-Z\d]+)/
    end

    def missing_encodings
      Encoding.name_list - Encoding.list.map {|enc| enc.name}
    end

    def encode_note_text(encoding, text)
      if Encoding.list.include? encoding
        text.encode encoding
      else
        text
      end
    end

    def has_tags?(note_text)
      !!(note_text =~ @tag_regex)
    end

    def parse_tags(note_text)
      note_text.scan(@tag_regex).flatten
    end
  end

  class Note
    attr_reader :header, :body, :encoding, :tag_char

    POSSIBLE_ENCODINGS = Encoding.list.map {|enc| enc.name}

    def initialize(header, body, tag_char, encoding=Encoding::UTF_8)
      @header = header
      @body = body
      @tag_char = tag_char
      @tag_regex = /(?:^|\s)(?:#{Regexp.quote(@tag_char)})([a-zA-Z\d]+)/
      @encoding = encoding unless !valid_encoding?(encoding)
    end

    def valid_encoding?(encoding)
      encoding and POSSIBLE_ENCODINGS.include? encoding
    end

    def get_note_tags
      {:header_tags => parse_tags(@header), :body_tags => parse_tags(@body)}
    end

    def get_encoded_note
      {:header => encode_text(@header), :body => encode_text(@body)}
    end

    protected
    def parse_tags(text)
      text.scan(@tag_regex).flatten
    end

    def encode_text(text)
      begin
        text.encode @encoding
      rescue Encoding::ConverterNotFoundError
        text
      end
    end
  end
end


