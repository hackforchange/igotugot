require 'rubygems'
require 'sinatra'
require './lib/models'
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
  else
    @posts = Post.order('posts.id DESC').limit(10)
  end
  @posts = @posts.includes('tags').where(["tags.name = ?", tags]) if tags != ""
  
end

post "/location" do
  puts params
  postal_code = params['postal_code']
  lat         = params['lat']
  lng         = params['lng']
  postal_code = postal_code.gsub " ", ""
  postal_code = postal_code.upcase
  if postal_code    
    p postal_code
    location = Location.from_postalcode(postal_code).to_s
    @user.postal_code = postal_code    
    lat = location['lat']
    lng = location['lng']
  end
  if lat && lng
    @user.lat = lat
    @user.lng = lng
    
  end
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
  @post.email = params['email']
  @post.lat   = @user.lat
  @post.lng   = @user.lng 
  @post.user = @user if @user
  @post.save  
  @user.contact_method = @post.contact_method
  @user.email = @post.email
  @user.save if @user.changed
  
  if params["tags"]
    tags = params['tags'].split(",")

    tags.each {|tag| 
      @post.tags << Tag.find_or_create_by_name( h tag)  
    }
  end


  redirect "/posts"
end 

get "/post/new" do
  @post = Post.new
  @post.contact_method = @user.contact_method if @user.contact_method
  @post.email          = @user.email if @user.email
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

post "/post/:secret_id/delete" do 
  @post = Post.find_by_secret_id(params[:secret_id])
  @post.destroy
  erb :new_post
  redirect "/posts"
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
    redirect "/post/#{post.id}"
  end
end  

get "/untag/:post_id/as/:tag_name" do
  post = Post.find(params[:post_id])
  tag = Tag.find_by_name(params[:tag_name])
  post.tags.delete(tag)
  if request.xhr?
  else
    redirect "/post/#{post.id}"
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


  def tag_list
    Tag.list
  end
  
end

