require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :email, :gender, :name, :date_of_birth,:password
  attr_accessor :password

  has_one :account
  has_many :transactions,:through => :account

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , :message => "Please enter a valid email"
  validates_presence_of :email,:name,:password,:date_of_birth
  validates_uniqueness_of :email, :message => "This email address is already registered"

  before_save :hash_new_password, :if=>:password_changed?
  after_create :set_account_for_user

  def balance
    self.account.balance
  end

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if BCrypt::Password.new(user.encrypted_password).is_password? password
        return user
      end
    end
    return nil
  end

  private

  def password_changed?
    !@password.blank?
  end

  def hash_new_password
    self.encrypted_password = BCrypt::Password.create(@password)
  end

  def set_account_for_user
    account=Account.new
    account.user=self
    account.balance=100
    account.save
  end

end
