class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :balance

      t.timestamps
    end
    execute("ALTER TABLE accounts AUTO_INCREMENT = 4000000")
    add_foreign_key :accounts,:users,:column => :user_id
  end
end
