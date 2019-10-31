class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :chapter, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :rank
      t.boolean :is_resource, default: false

      t.timestamps
    end
  end
end
