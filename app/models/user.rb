class User < ActiveRecord::Base
  has_many :bottles
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: { message: "Username already taken" }
  validates :email, uniqueness: { message: "Email already taken"}
end