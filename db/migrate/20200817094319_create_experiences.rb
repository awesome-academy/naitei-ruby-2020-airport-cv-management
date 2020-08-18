class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.string :job_position
      t.date :date_from
      t.date :date_to
      t.text :additional_information
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
