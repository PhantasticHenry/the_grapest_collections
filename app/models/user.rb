class User < ActiveRecord::Base
  has_many :bottles
  has_secure_password
  validates :username, :password, presence: true
  validates :username, uniqueness: { message: "Username already taken" }
end