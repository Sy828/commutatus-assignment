class CreateUserConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :user_connections do |t|
      t.integer :followable_id,null: false
      t.integer :follower_id,null: false

      t.timestamps
    end
  end
end
