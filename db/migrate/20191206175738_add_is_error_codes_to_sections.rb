class AddIsErrorCodesToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :is_error_codes, :boolean, default: false
  end
end
