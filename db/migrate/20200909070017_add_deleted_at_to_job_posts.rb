class AddDeletedAtToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :job_posts, :deleted_at, :datetime
    add_index :job_posts, :deleted_at
  end
end
