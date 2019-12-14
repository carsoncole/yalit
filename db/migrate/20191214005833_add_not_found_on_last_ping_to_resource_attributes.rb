class AddNotFoundOnLastPingToResourceAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :resource_attributes, :not_found_on_last_ping, :boolean, default: false
  end
end
