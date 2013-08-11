class CreateClocks < ActiveRecord::Migration
  def change
    create_table :clocks do |t|
      t.references :users, index: true
      t.references :statuses, index: true

      t.timestamps
    end
  end
end
