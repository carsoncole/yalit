class AddRequestMethodIdToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :request_method_id, :integer
  end
end
