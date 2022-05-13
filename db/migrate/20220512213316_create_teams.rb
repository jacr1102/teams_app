class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :team_members do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
