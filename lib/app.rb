require './lib/regex_highlighter'
require 'sinatra/cross_origin'
require 'oj'

class App < Sinatra::Base

  register Sinatra::CrossOrigin

  enable :cross_origin

  post "/" do
    Oj.dump(RegexHighlighter.new(params).highlights, mode: :compat)
  end
end
