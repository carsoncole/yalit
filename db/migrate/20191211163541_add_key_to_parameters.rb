class AddKeyToParameters < ActiveRecord::Migration[6.0]
  def change
    add_column :parameters, :key, :string
    add_column :parameters, :value, :string
  end
end
