require './lib/regex_highlighter'
require 'oj'

class App < Sinatra::Base
  post "/" do
    Oj.dump(RegexHighlighter.new(params).highlights)
  end
end
