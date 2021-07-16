class Catch < ActiveRecord::Base
  belongs_to :baits
  has_one :fish
end
