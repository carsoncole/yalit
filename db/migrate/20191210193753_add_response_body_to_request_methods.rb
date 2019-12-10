class AddResponseBodyToRequestMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :response_body, :text
  end
end
