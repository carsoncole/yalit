class CreateErrorCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :error_codes do |t|
      t.references :section, null: false, foreign_key: true
      t.string :title
      t.integer :http_status_code
      t.integer :custom_status_code
      t.string :description

      t.timestamps
    end
  end
end
