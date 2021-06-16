class User < ActiveRecord::Base
  has_many :catches
  has_many :fishes, through: :catches
  has_many :locations, through: :catches
end
