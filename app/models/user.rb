class User < ActiveRecord::Base
  has_many :bottles
  has_secure_password
end
