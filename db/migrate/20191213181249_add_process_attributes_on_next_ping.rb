class AddProcessAttributesOnNextPing < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :process_attributes_on_next_ping, :boolean, default: false, null: false
  end
end
