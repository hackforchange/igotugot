require 'rubygems'
require 'sinatra'
require 'lib/models'
require 'yaml'
enable :sessions
  
get '/' do
  session[:identity] ||= User.generate_id
  @user_id = session[:identity]
  erb :index
end

get "/sessions/clear" do
  session = {}
  session.to_yaml
end  

get "/sessions/show" do
  session.to_yaml
end  
