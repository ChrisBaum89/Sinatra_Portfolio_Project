class User < ActiveRecord::Base
  has_secure_password

  has_many :baits
  has_many :catches, through: :baits
  has_many :fishes, through: :catches

  validates_presence_of :username, :email, :password

end
