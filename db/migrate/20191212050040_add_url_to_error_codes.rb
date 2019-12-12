class AddUrlToErrorCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :error_codes, :url, :string
  end
end
