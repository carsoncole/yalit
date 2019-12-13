class AddMessageToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :message, :string
  end
end
