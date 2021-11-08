class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :bank
      t.decimal :balance, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
