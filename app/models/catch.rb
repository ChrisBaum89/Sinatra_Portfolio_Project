class Catch < ActiveRecord::Base
  belongs_to :users
  belongs_to :fish
  belongs_to :locations
  belongs_to :baits
end
