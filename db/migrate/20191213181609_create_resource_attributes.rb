class CreateResourceAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :resource_attributes do |t|
      t.references :section, null: false, foreign_key: true
      t.string :key
      t.boolean :is_required, default: false
      t.string :field_type, default: 'string'
      t.text :description

      t.timestamps
    end
  end
end
