class Account < ActiveRecord::Base
  attr_protected :balance
  belongs_to :user

  has_many :credit_transactions, :foreign_key => :to_account, :class_name => "Transaction",:order => :created_at
  has_many :debit_transactions, :foreign_key => :from_account, :class_name => "Transaction",:order => :created_at

end
