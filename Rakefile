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
        t.column "contact_method", :string
        t.column "postal_code", :string
        t.timestamps 
      end

      create_table "posts", :force => true do |t|    
        t.column "i_got", :text
        t.column "u_got", :text
        t.column "contact_method", :text
        t.column "email", :text
        t.column "secret_id", :string
        t.column "lat", :float
        t.column "lng", :float
        t.column "user_id", :integer
        t.timestamps 
      end

      create_table "tags", :force => true do |t|    
        t.column "name", :string 
        t.timestamps 
      end
      create_table "taggings", :force => true do |t|    
        t.column "tag_id", :integer
        t.column "post_id", :integer
        t.column "user_id", :integer
        t.timestamps 
      end



    end
  end 

  desc "Fill with noise"
  task(:fill) do
    jabberwock = <<-JABBER
    <font size="+2"> 
    `Twas brillig, and the slithy toves<br> 
    &nbsp;&nbsp;Did gyre and gimble in the wabe:<br> 
    All mimsy were the borogoves,<br> 
    &nbsp;&nbsp;And the mome raths outgrabe.<p> 
    </center> 

    <img src="/pics/jabberwocky.jpg" align="right" border=0 width=291 
    height=432> 

    <p><br> 

    "Beware the Jabberwock, my son!<br> 
    &nbsp;&nbsp;The jaws that bite, the claws that catch!<br> 
    Beware the Jubjub bird, and shun<br> 
    &nbsp;&nbsp;The frumious Bandersnatch!"<br> 

    <p> 

    He took his vorpal sword in hand:<br> 
    &nbsp;&nbsp;Long time the manxome foe he sought --<br> 
    So rested he by the Tumtum tree,<br> 
    &nbsp;&nbsp;And stood awhile in thought.<br> 

    <p> 

    And, as in uffish thought he stood,<br> 
    &nbsp;&nbsp;The Jabberwock, with eyes of flame,<br> 
    Came whiffling through the tulgey wood,<br> 
    &nbsp;&nbsp;And burbled as it came!<br> 

    <p> 

    One, two!  One, two!  And through and through<br> 
    &nbsp;&nbsp;The vorpal blade went snicker-snack!<br> 
    He left it dead, and with its head<br> 
    &nbsp;&nbsp;He went galumphing back.<br> 

    <p> 

    "And, has thou slain the Jabberwock?<br> 
    &nbsp;&nbsp;Come to my arms, my beamish boy!<br> 
    O frabjous day!  Callooh!  Callay!'<br> 
    &nbsp;&nbsp;He chortled in his joy.<br> 

    <br clear="all"><center><br> 

    `Twas brillig, and the slithy toves<br> 
    &nbsp;&nbsp;Did gyre and gimble in the wabe;<br> 
    All mimsy were the borogoves,<br> 
    &nbsp;&nbsp;And the mome raths outgrabe.

    <p>
    JABBER
    haves = ['broccoli', 'cabbage', 'bok choy', 'horseradish', 'mustard greens', 'arugula', 'brussels sprouts', 'cauliflower', 'radishes', 'kohlrabi', 'broccoli rabe', 'organic kale', 'collards', 'turnips', 'rutabaga', 'watercress', 'beets', 'yams', 'carrots', 'parsnips', 'radish', 'potatoes', 'sweet potatoes', 'zucchini', 'strawberries', 'blueberries', 'grapes', 'rhubarb', 'home-brew beer', 'coffee beans','carrots', 'eggs', 'spinach', 'rhubarb', 'so much rhubarb', 'beans', 'basil', 'honey', 'zuchinni', 'cukes','lettuce','almonds', 'hazelnuts']
    wants = ['broccoli', 'cabbage', 'bok choy', 'horseradish', 'mustard greens', 'arugula', 'brussels sprouts', 'cauliflower', 'radishes', 'kohlrabi', 'broccoli rabe', 'organic kale', 'collards', 'turnips', 'rutabaga', 'watercress', 'beets', 'yams', 'carrots', 'parsnips', 'radish', 'potatoes', 'sweet potatoes', 'zucchini', 'strawberries', 'blueberries', 'grapes', 'rhubarb', 'home-brew beer', 'coffee beans','carrots', 'eggs', 'spinach', 'rhubarb', 'so much rhubarb', 'beans', 'basil', 'honey', 'zuchinni', 'cukes','lettuce','almonds', 'hazelnuts']
    tags = ['tasty', 'friendly', 'sketchy', 'so good', 'organic', 'vegetables','fruit','nuts','spinach','greens','root veg','canned','broccoli', 'cabbage', 'bok choy', 'horseradish', 'mustard greens', 'arugula', 'brussels sprouts', 'cauliflower', 'radishes', 'kohlrabi', 'broccoli rabe', 'organic kale', 'collards', 'turnips', 'rutabaga', 'watercress', 'beets', 'yams', 'carrots', 'parsnips', 'radish', 'potatoes', 'sweet potatoes', 'zucchini', 'strawberries', 'blueberries', 'grapes', 'rhubarb', 'home-brew beer', 'coffee beans','carrots', 'eggs', 'spinach', 'rhubarb', 'so much rhubarb', 'beans', 'basil', 'honey', 'zuchinni', 'cukes','lettuce','almonds', 'hazelnuts']
    contacts = ['give me a call :) 515-222-2134', 'please email me, sirspamalot@email.com', 'call after 6pm, 415-555-5553']
    amounts = ['a handful of', 'a pound of', 'a wheelbarrel of', 'so much', 'more than i can use', 'a bit of', 'hella', 'hecka', 'my goodness, so muuch', 'some']
    100.times do
      post = Post.create(
               :i_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} #{haves[rand(haves.length)]}", 
               :u_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} ",
               :contact_method => contacts[rand(contacts.length)],
               :lat => "34.10300320 - (rand() * 5)", 
               :lng => "-118.41046840 - (rand() * 5)")
      rand(4).times { 
        begin 
          post.tags << Tag.find_or_create_by_name(:name => tags[rand(tags.length)])
        rescue
        end   
          }
      
    end
  end
end
