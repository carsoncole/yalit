class CreateSubSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_sections do |t|
      t.references :section, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :rank
      t.boolean :is_verb, default: false

      t.timestamps
    end
  end
end
