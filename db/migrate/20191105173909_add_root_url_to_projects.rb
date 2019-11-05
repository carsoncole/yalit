class AddRootUrlToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :root_url, :string
  end
end
