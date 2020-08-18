class CreateJobApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :job_applications do |t|
      t.references :candidate, index: true, foreign_key: {to_table: :users}
      t.references :recruiter, index: true, foreign_key: {to_table: :users}
      t.references :job_application_status, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
