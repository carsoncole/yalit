class AddContentToRequestMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :content, :text
    remove_column :request_methods, :description, :string
  end
end
