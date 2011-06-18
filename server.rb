require 'rubygems'
require 'sinatra'
require 'lib/models'
enable :sessions
  
get '/' do
  session[:identity] ||= User.generate_id
  @user_id = session[:identity]
  erb :index
end

