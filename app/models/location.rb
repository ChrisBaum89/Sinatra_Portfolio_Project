class Location < ActiveRecord::Base
  belongs_to :catches
  has_many :fish
end
