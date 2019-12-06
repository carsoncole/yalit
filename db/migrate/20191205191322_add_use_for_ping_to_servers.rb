class AddUseForPingToServers < ActiveRecord::Migration[6.0]
  def change
    add_column :servers, :use_for_ping, :boolean, default: false
  end
end
