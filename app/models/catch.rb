class Catch < ActiveRecord::Base
  belongs_to :users
  belongs_to :fishes
  belongs_to :locations
end
