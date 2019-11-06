class RemoveColumnContentFromRequestMethods < ActiveRecord::Migration[6.0]
  def change
    remove_column :request_methods, :content, :string
  end
end
