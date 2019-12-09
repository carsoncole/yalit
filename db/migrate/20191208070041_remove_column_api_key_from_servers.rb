class RemoveColumnApiKeyFromServers < ActiveRecord::Migration[6.0]
  def change
    remove_column :servers, :api_key, :string
  end
end
