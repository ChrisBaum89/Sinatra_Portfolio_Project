class Bait < ActiveRecord::Base
  has_many :catches
  belongs_to :users
end
