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

def easy_partial template
  erb template.to_sym, :layout => false
end

post "/location" do
  puts params
  postal_code = params['postal_code']
  if postal_code    
    location = Location.from_postalcode(postal_code).to_s
  end
  if params['lat'] && params['lng'] 
    location = {}
    location[:lat] = params['lat']
    location[:lng] = params['lng']        
  end
  session[:lat] = location[:lat]
  session[:lng] = location[:lng] 
  redirect "/posts"
end

get "/posts" do
  erb :posts  
end 

get "/posts/new" do
  erb :new_post  
end 

get "/sessions/clear" do
  session = {}
  session.to_yaml
end  

get "/sessions/show" do
  session.to_yaml
end  
