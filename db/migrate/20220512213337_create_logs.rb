class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.references :users, foreign_key: true
      t.references :account_from, foreign_key: { to_table: :accounts}
      t.references :account_to, foreign_key: { to_table: :accounts}

      t.timestamps
    end
  end
end
