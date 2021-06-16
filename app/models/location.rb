class Location < ActiveRecord::Base
  has_many :catches
  has_many :users, through: :catches
  has_many :fish, through: :catches
  has_many :baits, through: :catches
end
