class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :introduction
      t.date :date_of_birth
      t.text :address
      t.string :phone_number
      t.references :user, null: false, foreign_key: true
      t.integer :gender, default: 3

      t.timestamps
    end
  end
end
