class RenameUrlToPathOnRequestMethods < ActiveRecord::Migration[6.0]
  def change
    rename_column :request_methods, :url, :path
  end
end
