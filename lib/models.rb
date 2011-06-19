require 'rubygems'
require 'active_record'

dbconfig = YAML.load(File.read('./config/database.yml'))
env = ENV['SINATRA_ENV'] || 'production'
ActiveRecord::Base.establish_connection dbconfig['production']

class User < ActiveRecord::Base
  has_many :tags, :through => :taggings
  has_many :taggings
  has_many :posts
end

require 'digest/sha1'

class Post < ActiveRecord::Base
  before_create :set_edit_url
  has_many :tags, :through => :taggings
  has_many :taggings
  belongs_to :user
  def set_edit_url   
    # is it awesome to random?
    self.secret_id = Digest::SHA1.hexdigest("#{rand}")    
  end
  
end

class Tag < ActiveRecord::Base
    has_many :posts, :through => :taggings
    has_many :users, :through => :taggings
    after_create :kill_memos
    def self.list
      @tags ||= self.all.collect{|tag| tag.name}
    end
    def kill_memos
      @tags = nil
    end
end

class Tagging < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    belongs_to :tag
    validates_uniqueness_of :tag_id, :scope => :post_id
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