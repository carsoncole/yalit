class AddDomainToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :domain, :string
    add_column :projects, :ssl_endpoint_domain, :string
  end
end
