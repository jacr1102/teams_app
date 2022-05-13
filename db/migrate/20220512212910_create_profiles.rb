class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :english_level
      t.text :technical_experience
      t.string :cv_link

      t.timestamps
    end
  end
end
