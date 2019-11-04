class AddHerokuAcmUpdatedAtToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :heroku_acm_updated_at, :datetime
  end
end
