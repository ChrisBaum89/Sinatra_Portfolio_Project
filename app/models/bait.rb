class Bait < ActiveRecord::Base
  belongs_to :users
  has_many :catches
end
