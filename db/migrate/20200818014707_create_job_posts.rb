class CreateJobPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :job_posts do |t|
      t.string :title
      t.string :location
      t.integer :salary_from
      t.integer :salary_to
      t.string :note
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.text :description
      t.text :requirement

      t.timestamps
    end
  end
end
