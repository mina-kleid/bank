class Account < ActiveRecord::Base
  attr_protected :balance
  belongs_to :user

  def transaction(destination_account,amount)
    transaction=Transaction.new
    transaction.source_account=self
    transaction.destination_account=destination_account
    transaction.amount=amount
    return transaction.save
  end
end
