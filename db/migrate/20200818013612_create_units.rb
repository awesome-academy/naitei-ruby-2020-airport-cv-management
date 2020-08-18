class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone_number
      t.text :overview

      t.timestamps
    end
  end
end
