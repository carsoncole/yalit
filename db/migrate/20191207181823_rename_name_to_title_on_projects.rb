class RenameNameToTitleOnProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :name, :title
  end
end
