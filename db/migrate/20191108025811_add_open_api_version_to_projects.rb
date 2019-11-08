class AddOpenApiVersionToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :open_api_version, :string
  end
end
