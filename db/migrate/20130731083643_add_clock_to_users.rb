class AddClockToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :clock, index: true
    end
  end
end
