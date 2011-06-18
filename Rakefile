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
        t.column "long", :float
        t.timestamps 
      end

    end
  end 
end
