require 'rubygems'
require 'active_record'

dbconfig = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']

class User < ActiveRecord::Base
    
end

class Post < ActiveRecord::Base

end