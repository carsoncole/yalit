class RemoveColumnProcessAttributesOnNextPingFromRequestMethods < ActiveRecord::Migration[6.0]
  def change
    remove_column :request_methods, :process_attributes_on_next_ping, :boolean
  end
end
