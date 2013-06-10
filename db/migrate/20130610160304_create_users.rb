class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :gender
      t.date :date_of_birth

      t.timestamps
    end
  end
end
