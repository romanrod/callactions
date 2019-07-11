require 'mongoid'
require 'will_paginate_mongoid'

Mongoid.load! "#{Dir.pwd}/config/mongo_db.config"

Dir["./lib/*.rb"].each {|rb| require rb}

class Activity

  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  belongs_to :contact
  
  field :id, type: BSON::ObjectId 
  # field :contact_id, type: String
  field :description, type: String
  
  validates_presence_of :description

  index({contact_id: 'text'})
  
end