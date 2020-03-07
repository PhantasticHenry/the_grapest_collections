class Bottle < ActiveRecord::Base
  belongs_to :user
  validates :wine_type, :vintage, :price, presence: true
end
