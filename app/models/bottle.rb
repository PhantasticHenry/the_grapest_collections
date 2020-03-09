class Bottle < ActiveRecord::Base
  belongs_to :user
  validates :name, :grape, :style, :vintage, :price, presence: true
end
