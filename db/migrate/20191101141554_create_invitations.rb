class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :project, null: false, foreign_key: true
      t.string :email
      t.string :role
      t.integer :invited_by_user_id

      t.timestamps
    end
  end
end
