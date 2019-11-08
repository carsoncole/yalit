class Parameters < ActiveRecord::Migration[6.0]
  def change
    create_table :parameters do |t|
      t.references :request_method, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :type, default: 'integer'
      t.boolean :is_required, default: true

      t.timestamps
    end
  end
end
