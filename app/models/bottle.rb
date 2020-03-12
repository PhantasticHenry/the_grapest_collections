class Bottle < ActiveRecord::Base
  belongs_to :user
  validates :name, :vintage, :price, presence: true
end
