class AddIsPublishedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :is_published, :boolean, default: false
  end
end
