class ReCreateLogsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :logs
    create_table :user_logs do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.string :action, null: false

      t.timestamps
    end
  end
end
