class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :rank

      t.timestamps
    end
  end
end
