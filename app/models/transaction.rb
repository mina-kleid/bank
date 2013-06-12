class TransactionValidator< ActiveModel::Validator
  def validate(record)
    if record.new_record?
      if record.source_account
         if record.source_account.balance - record.amount < 0
           record.errors[:base] << "Sorry! you dont have sufficient funds for this transaction"
         end
         if record.to_account
           if Account.where(:id => record.to_account).empty?
             record.errors[:base] << "Sorry! You have entered a wrong account number"
           end
         end
        if record.to_account.eql?(record.from_account)
          record.errors[:base] << "You cannot transfer money to yourself"
        end
      else
        record.errors[:base] << "Sorry! something went wrong, Please contact our support team"
      end
    end
  end
end

class Transaction < ActiveRecord::Base
  belongs_to :source_account,:foreign_key => :from_account,:class_name => "Account"
  belongs_to :destination_account,:foreign_key => :to_account,:class_name => "Account"

  has_one :source_user,:through => :source_account,:source => :user
  has_one :destination_user,:through => :destination_account,:source => :user
  validates_with TransactionValidator
  after_create :modify_balance_for_users
  validates_numericality_of :to_account,:from_account,:amount
  validates_presence_of :to_account,:from_account,:amount
  private
  def modify_balance_for_users

    self.transaction do
      self.source_account.balance=self.source_account.balance - self.amount
      self.source_account.save
      self.destination_account.balance = self.destination_account.balance + self.amount
      self.destination_account.save
      self.is_completed=true
      self.save
    end
  end
end
