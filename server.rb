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

post "/post" do
  @post = Post.new()
  @post.i_got = params["i_got"]
  @post.u_got = params["u_got"]
  @post.lat   = session['lat']
  @post.lng   = session['lng']
  @post.save
  
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
