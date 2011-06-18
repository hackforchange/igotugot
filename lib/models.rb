require 'rubygems'
require 'active_record'

dbconfig = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']

class User < ActiveRecord::Base
  def self.generate_id
    "user_#{Time.now.to_i}" 
  end    
end

class Post < ActiveRecord::Base

end

class Location 
  def latlong_from_postalcode(postcode)
    #there is apparently a postalcode thing
    "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{postcode}"
    lat = "0"
    long = "0"
    {:lat => lat, :long => long}
  end  
end