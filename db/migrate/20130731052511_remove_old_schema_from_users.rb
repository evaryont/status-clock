class RemoveOldSchemaFromUsers < ActiveRecord::Migration
  def change
    # We now have any number of statuses in the clock, not just 6, remove them
    remove_column :users, :status_1
    remove_column :users, :status_2
    remove_column :users, :status_3
    remove_column :users, :status_4
    remove_column :users, :status_5
    remove_column :users, :status_6

    change_table :users do |t|
      t.references :status, index: true
      t.integer :hand
    end
  end
end
