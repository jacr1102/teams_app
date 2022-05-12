class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.references :accounts, foreign_key: true
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
