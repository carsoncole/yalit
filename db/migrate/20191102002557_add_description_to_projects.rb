class AddDescriptionToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :description, :string
    add_column :projects, :terms_of_service_url, :string
    add_column :projects, :contact_name, :string
    add_column :projects, :contact_url, :string
    add_column :projects, :contact_email, :string
    add_column :projects, :license_name, :string
    add_column :projects, :license_url, :string
    add_column :projects, :version, :string
  end
end
