class User < ActiveRecord::Base
  has_many :catches
  has_many :fish, through: :catches
  has_many :locations, through: :catches
  has_many :baits, through: :catches

end
