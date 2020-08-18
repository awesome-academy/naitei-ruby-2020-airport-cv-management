class CreateEducations < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.string :college
      t.string :major
      t.date :graduation
      t.text :certification
      t.text :additional_information
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
