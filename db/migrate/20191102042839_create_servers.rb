class CreateServers < ActiveRecord::Migration[6.0]
  def change
    create_table :servers do |t|
      t.references :project, null: false, foreign_key: true
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
