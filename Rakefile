require 'rubygems'
require "active_record"
require './server.rb'

dbconfig = YAML.load(File.read('config/database.yml'))
env = ENV['SINATRA_ENV'] || 'production'
ActiveRecord::Base.establish_connection dbconfig[env]

namespace :db do
  desc "Migrate the database"
  task(:prepare) do
    ActiveRecord::Schema.define do

      create_table "users", :force => true do |t|    
        t.column "id_string", :string    
        t.column "email", :string
        t.column "lat", :float
        t.column "lng", :float
        t.column "postal_code", :string
        t.timestamps 
      end

      create_table "posts", :force => true do |t|    
        t.column "i_got", :text
        t.column "u_got", :text
        t.column "secret_id", :string
        t.column "lat", :float
        t.column "lng", :float
        t.timestamps 
      end

      create_table "tags", :force => true do |t|    
        t.column "name", :string
        t.timestamps 
      end
      create_table "taggings", :force => true do |t|    
        t.column "tag_id", :string
        t.column "post_id", :integer
        t.column "user_id", :integer
        t.timestamps 
      end



    end
  end 

  desc "Fill with noise"
  task(:fill) do
    haves = ['fairy king prawn', 'bubblegum fellow', 'saga novel', 'orion the thanks', 'grass world', 'air eminem', 'air jihad', 'Ibuki Government', 'Fine Motion', 'Broad Appeal']
    wants = ['carrots', 'eggs', 'spinach', 'rhubarb', 'so much fucking rhubarb', 'beans', 'a new frying pan', 'basil', 'honey', 'ektorp', 'zuchinni', 'cukes', 'rabbits', 'let us', 'lettuce']
    tags = ['good', 'bad', 'ugly', 'sketchy', 'so good', 'so bad', 'so ugly', 'so sketchy', 'do it motherfucker']
    amounts = ['a handful of', 'a pound of', 'a wheelbarrel of', 'so much', 'so fucking much', 'a bit of', 'hella', 'hecka', 'a shit-tonne of']
    100.times do
      post = Post.create(
               :i_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} and A horse named #{haves[rand(haves.length)]}", 
               :u_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]}",
               :lat => "37.7969962 - (rand() * 5)", 
               :lng => "-122.405689 - (rand() * 5)")
      rand(4).times { post.tags << Tag.create(:name => tags[rand(tags.length)])}
      
    end
  end
end
