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
        t.column "tag_id", :string
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
    haves = ['fairy king prawn', 'bubblegum fellow', 'saga novel', 'orion the thanks', 'grass world', 'air eminem', 'air jihad', 'Ibuki Government', 'Fine Motion', 'Broad Appeal', jabberwock]
    wants = ['carrots', 'eggs', 'spinach', 'rhubarb', 'so much fucking rhubarb', 'beans', 'a new frying pan', 'basil', 'honey', 'ektorp', 'zuchinni', 'cukes', 'rabbits', 'let us', 'lettuce']
    tags = ['good', 'bad', 'ugly', 'sketchy', 'so good', 'so bad', 'so ugly', 'so sketchy', 'do it motherfucker']
    amounts = ['a handful of', 'a pound of', 'a wheelbarrel of', 'so much', 'so fucking much', 'a bit of', 'hella', 'hecka', 'a shit-tonne of']
    100.times do
      post = Post.create(
               :i_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} and A horse named #{haves[rand(haves.length)]}", 
               :u_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} ",
               :lat => "37.7969962 - (rand() * 5)", 
               :lng => "-122.405689 - (rand() * 5)")
      rand(4).times { post.tags << Tag.create(:name => tags[rand(tags.length)])}
      
    end
  end
end
