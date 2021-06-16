class Catch < ActiveRecord::Base
  belongs_to :users
  belongs_to :fish
  belongs_to :locations
end
