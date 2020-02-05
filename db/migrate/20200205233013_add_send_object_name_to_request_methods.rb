class AddSendObjectNameToRequestMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :send_object_name, :string
    add_column :request_methods, :send_as_array, :boolean, default: false
  end
end
