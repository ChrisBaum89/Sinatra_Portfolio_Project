class Fish < ActiveRecord::Base
  belongs_to :catches
  belongs_to :location
end
