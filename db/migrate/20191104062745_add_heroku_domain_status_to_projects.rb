class AddHerokuDomainStatusToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :heroku_domain_status, :string
  end
end
