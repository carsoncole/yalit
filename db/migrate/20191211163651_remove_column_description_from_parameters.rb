class RemoveColumnDescriptionFromParameters < ActiveRecord::Migration[6.0]
  def change
    remove_column :parameters, :description, :string
    remove_column :parameters, :is_required, :boolean
    remove_column :parameters, :type, :string
    remove_column :parameters, :name, :string
  end
end
