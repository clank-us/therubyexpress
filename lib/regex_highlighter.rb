class RegexHighlighter
  attr_reader :pattern, :flags, :test_string

  def initialize(match_params)
    @pattern      =  match_params.fetch("pattern", "")
    @flags        =  match_params.fetch("flags", "")
    @test_string  =  match_params.fetch("test_string", "")
  end

  def highlights
    {
      match_data: match_data,
      captures: captures,
      match_string: match_string
    }
  end

  def match_data
    matches.flatten
  end

  def captures
    return matches if matches.first.class == Array
    []
  end

  def matches
    @matches ||= test_string.scan(built_regex)
  end

  def built_regex
    @built_regex ||= Regexp.new(pattern, flags)
  end

  def match_string
    test_string.gsub(built_regex) do |match|
      "--{#{match}}--"
    end
  end

end
