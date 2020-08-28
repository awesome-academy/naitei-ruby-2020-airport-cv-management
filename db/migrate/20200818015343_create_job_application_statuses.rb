class CreateJobApplicationStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :job_application_statuses do |t|
      t.string :title  
      t.timestamps
    end
  end
end
