class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name, nul: false
      t.string :client_name, nul: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
