class CreateRequestMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :request_methods do |t|
      t.references :section, null: false, foreign_key: true
      t.string :verb
      t.string :title
      t.string :description
      t.string :url
      t.text :request_content
      t.text :response_content
      t.integer :rank

      t.timestamps
    end
  end
end
