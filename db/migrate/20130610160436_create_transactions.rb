class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from_account
      t.integer :to_account
      t.decimal :amount
      t.boolean :is_completed,:default => false
      t.timestamps
    end
    add_foreign_key :transactions,:accounts ,:column => :from_account
    add_foreign_key :transactions,:accounts ,:column => :to_account
  end
end
