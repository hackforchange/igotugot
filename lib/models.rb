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

require 'json'
require 'open-uri'
class Location 
  def self.from_postalcode(postcode)
    #there is apparently a postalcode thing
    location = {}
    begin
    url = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{postcode}"
    json = open(url).read
    parsed_json = JSON(json)
    parsed_location = parsed_json["results"].first['geometry']['location']
    location['lat'] = parsed_location['lat'].to_s
    location['lng'] = parsed_location['lng'].to_s
    rescue
    end
    
    lat = location['lat'] || "0"
    lng = location['lng'] || "0"
    
    {:lat => lat, :lng => lng}
  end  
end