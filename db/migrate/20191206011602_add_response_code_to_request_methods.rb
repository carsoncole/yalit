class AddResponseCodeToRequestMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :request_methods, :response_code, :integer
  end
end
