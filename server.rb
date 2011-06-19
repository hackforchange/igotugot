require 'rubygems'
require 'sinatra'
require 'lib/models'
require 'yaml'
enable :sessions
  
before do  
    if session['identity'] 
      begin
      @user = User.find(session['identity'])
      rescue
       @user = User.create
      end
    else
      @user = User.create
      session['identity'] = @user.id
    end
end


get '/' do  
  @page = "front"
  erb :index
end

def easy_partial template
  erb template.to_sym, :layout => false
end

def get_posts(lat, lng, proximity, tags = "")
  case params[:proximity]
    when 'not_so_close' then
      proximity = 1.5
    when 'nearby' then
      proximity = 1
    when 'close' then
      proximity = 0.5
    else 
      proximity = 1  
  end  
  if lat && lng
    @posts = Post.
    includes('tags').
    where(["lng between ? AND ?", lng - proximity, lng + proximity]).
    where(["lat between ? AND ?", lat - proximity, lat + proximity]).
    order('posts.id DESC')
    @posts = @posts.where(["tags.name = ?", tags]) if tags != ""
    #.where(["lat between ? AND ?", lat - 1, lat + 1])
  else
    @posts = Post.order('id DESC').limit(10)
  end
  
end

post "/location" do
  puts params
  postal_code = params['postal_code']
  if postal_code    
    location = Location.from_postalcode(postal_code).to_s
    @user.postal_code = postal_code    
    puts location
  end
  if params['lat'] && params['lng'] 
    location = {}
    location[:lat] = params['lat']
    location[:lng] = params['lng']        
  end
  @user.lat = location[:lat] || location['lat']
  @user.lng = location[:lng] || location['lng']
  @user.save
  p @user
  
  redirect "/posts"
end

get "/posts" do
  redirect "/posts/nearby"
end

get "/posts/:proximity/tagged/:tags" do
  lat = @user.lat 
  lng = @user.lng 
  proximity = params[:proximity]
  tags = params[:tags]
  
  get_posts(lat, lng, proximity, tags)
  erb :posts  
  
end
get "/posts/:proximity" do
  lat = @user.lat 
  lng = @user.lng 
  proximity = params[:proximity]
  
  get_posts(lat, lng, proximity)
  erb :posts  
end 


post "/post" do
  @page = 'single'
  @post = Post.new()
  @post.i_got = params["i_got"]
  @post.u_got = params["u_got"]
  @post.contact_method = params["contact"]
  @post.lat   = @user.lat
  @post.lng   = @user.lng 
  @post.user = @user if @user
  @post.save  
  @user.contact_method = @post.contact_method
  @user.save if @user.changed
  redirect "/posts"
end 

get "/post/new" do
  @post = Post.new
  @post.contact_method = @user.contact_method
  erb :new_post  
end 

get "/post/:id" do 
  @post = Post.find(params[:id])
  erb :show_post  
end 

get "/post/:secret_id/edit" do 
  @editing = true
  @post = Post.find_by_secret_id(params[:secret_id])
  erb :new_post  
end 

post "/tag/:post_id/as/:tag_name" do
 
  post = Post.find(params[:post_id])
  tag = Tag.find_or_create_by_name(params[:tag_name])
  begin
    # will die if not globally unique
    post.tags << tag
  rescue
    # so we return a blank
    tag.name = nil
  end
  if request.xhr?
    tag.name
  else
    redirect "/posts/#{post.id}"
  end
end  

post "/untag/:post_id/as/:tag_name" do
 
  post = Post.find(params[:post_id])
  tag = Tag.find_by_name(params[:tag_name])
  

  if request.xhr?
  else
    redirect "/posts/#{post.id}"
  end
end  


get "/sessions/clear" do
  session.clear
  session.to_yaml
end  

get "/sessions/show" do
  session.to_yaml
end  

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

