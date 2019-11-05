class AddIsHostedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :is_hosted, :boolean, default: false
  end
end
