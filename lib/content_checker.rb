class ContentChecker
  attr_reader :tag_char

  def initialize(tag_char="#")
    @tag_char = tag_char
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
