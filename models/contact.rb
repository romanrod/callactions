require 'mongoid'
require 'will_paginate_mongoid'

Mongoid.load! "#{Dir.pwd}/config/mongo_db.config"

Dir["./lib/*.rb"].each {|rb| require rb}

class Contact

  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  has_many :activities, dependent: :delete_all
  
  field :id, type: BSON::ObjectId
  field :first_name, type: String
  field :last_name, type: String
  field :cell_phone, type: String
  field :zip_code, type: Integer
  
  validates_presence_of :first_name, :last_name, :cell_phone, :zip_code
  validates_numericality_of :zip_code, only_integer: true
  
  index({id: 'text'})

  scope :first_name, -> (first_name){where(first_name: first_name)}
  scope :last_name, -> (last_name){where(last_name: last_name)}
  scope :cell_phone, -> (cell_phone){where(cell_phone: cell_phone)}
  scope :zip_code, -> (zip_code){where(zip_code: zip_code)}
  
  def has_activity? act
    self.activities.include? act
  end

end