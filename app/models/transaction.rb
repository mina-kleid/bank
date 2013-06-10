class Transaction < ActiveRecord::Base
  attr_accessible :amount, :from_account, :is_completed, :to_account
end
