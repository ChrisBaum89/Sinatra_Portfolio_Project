class Bait < ActiveRecord::Base
  has_many :catches
  has_many :users, through: :catches
  has_many :fish, through: :catches
  has_many :locations, through: :catches
end
