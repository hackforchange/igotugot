require 'rubygems'
require 'sinatra'

enable :sessions
  
get '/' do
  "welcome"
end
