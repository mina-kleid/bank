class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.int :from_account
      t.int :to_account
      t.decimal :amount
      t.boolean :is_completed

      t.timestamps
    end
  end
end
