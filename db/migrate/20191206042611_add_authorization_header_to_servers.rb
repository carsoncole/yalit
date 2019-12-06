class AddAuthorizationHeaderToServers < ActiveRecord::Migration[6.0]
  def change
    add_column :servers, :authorization_header, :string
    add_column :servers, :content_type_header, :string, default: 'application/json'
  end
end
