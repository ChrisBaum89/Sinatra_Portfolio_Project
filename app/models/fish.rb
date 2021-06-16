class Fish < ActiveRecord::Base
  has_many :catches
  has_many :users, through: :catches
  has_many :locations, through: :catches
end
