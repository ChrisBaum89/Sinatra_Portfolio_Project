class UserController < ActiveRecord::Base
  has_many :baits
  has_many :catches, through: :baits
  has_many :fish, through: :catches
end
