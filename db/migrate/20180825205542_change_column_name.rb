class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :jobs_id, :job_id
  end
end
