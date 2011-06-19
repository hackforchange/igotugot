require 'rubygems'
require "active_record"
require './server.rb'

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']

namespace :db do
  desc "Migrate the database"
  task(:prepare) do
    ActiveRecord::Schema.define do

      create_table "users", :force => true do |t|    
        t.column "id_string", :string    
        t.column "email", :string
        t.column "lat", :float
        t.column "long", :float
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

    end
  end 

  desc "Fill with noise"
  task(:fill) do
    haves = ['fairy king prawn', 'bubblegum fellow', 'saga novel', 'orion the thanks', 'grass world', 'air eminem', 'air jihad', 'Ibuki Government', 'Fine Motion', 'Broad Appeal']
    wants = ['carrots', 'eggs', 'spinach', 'rhubarb', 'so much fucking rhubarb', 'beans', 'a new frying pan', 'basil', 'honey', 'ektorp', 'zuchinni', 'cukes', 'rabbits', 'let us', 'lettuce']
    amounts = ['a handful of', 'a pound of', 'a wheelbarrel of', 'so much', 'so fucking much', 'a bit of', 'hella', 'hecka', 'a shit-tonne of']
    100.times do
      Post.create(:i_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} and A horse named #{haves[rand(haves.length)]}", :u_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]}")
    end
  end
end
