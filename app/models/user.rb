class User < ActiveRecord::Base
  attr_accessible :account_id, :email, :encrypted_password, :gender, :name
end
