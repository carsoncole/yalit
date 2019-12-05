class AddIsBetaUserToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_beta_user, :boolean, default: false
  end
end
