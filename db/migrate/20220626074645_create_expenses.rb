class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :description
      t.boolean :deactivated , null: false, default: false 
      t.integer :created_by
      t.timestamps
    end
  end
end
