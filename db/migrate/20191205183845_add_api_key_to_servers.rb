class AddApiKeyToServers < ActiveRecord::Migration[6.0]
  def change
    add_column :servers, :api_key, :string
  end
end
