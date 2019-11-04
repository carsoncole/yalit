class RenameColumnHerokuAcmCreatedOnProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :heroku_acm_created, :heroku_acm_created_at
  end
end
