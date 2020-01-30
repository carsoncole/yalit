class AddFieldTypeToParameters < ActiveRecord::Migration[6.0]
  def change
    add_column :parameters, :field_type, :string, default: "String"
  end
end
