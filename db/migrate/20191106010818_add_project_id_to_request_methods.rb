class AddProjectIdToRequestMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :project_id, :integer
  end
end
