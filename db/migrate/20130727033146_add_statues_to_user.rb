class AddStatuesToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :status_1
      t.string :status_2
      t.string :status_3
      t.string :status_4
      t.string :status_5
      t.string :status_6
    end
  end
end
