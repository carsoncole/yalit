class AddErrorsEndpointPathToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :error_endpoint_path, :string
  end
end
