class Location < ActiveRecord::Base
  has_many :catches
  has_many :users, through: :catches
  has_many :fishes, through: :catches
end
