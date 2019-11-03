class RenameDomainToHostnameOnProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :domain, :host_name
  end
end
