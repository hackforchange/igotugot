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
  @user.lat = location[:lat]
  @user.lng = location[:lng] 
  @user.save
  redirect "/posts"
end

get "/posts" do
  redirect "/posts/nearby"
end
get "/posts/:proximity" do
  lat = @user.lat 
  lng = @user.lng 
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
    where(["lng between ? AND ?", lng - proximity, lng + proximity]).
    where(["lat between ? AND ?", lat - proximity, lat + proximity]).
    order('id DESC')
    #.where(["lat between ? AND ?", lat - 1, lat + 1])
  else
    @posts = Post.order('id DESC').limit(10)
  end
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

get "/post/new" do
  erb :new_post  
end 

get "/post/:id" do 
  @post = Post.find(params[:id])
  erb :show_post  
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


