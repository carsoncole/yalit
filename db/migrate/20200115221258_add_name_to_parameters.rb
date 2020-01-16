class AddNameToParameters < ActiveRecord::Migration[6.0]
  def change
    add_column :parameters, :name, :string
    add_column :parameters, :is_required, :boolean, default: false
    add_column :parameters, :description, :text
    add_column :parameters, :default_value, :string
  end
end
