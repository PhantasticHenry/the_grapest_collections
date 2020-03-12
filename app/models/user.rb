class User < ActiveRecord::Base
  has_many :bottles
  has_secure_password
  validates :username, :password, presence: true
  validates :username, uniqueness: { message: "already taken" }
end
