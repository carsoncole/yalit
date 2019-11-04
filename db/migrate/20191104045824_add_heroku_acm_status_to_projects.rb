class AddHerokuAcmStatusToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :heroku_acm_status, :string
    add_column :projects, :heroku_acm_status_reason, :string
    add_column :projects, :heroku_cname, :string
    add_column :projects, :heroku_acm_created, :datetime
    add_column :projects, :heroku_acm_id, :string
  end
end
