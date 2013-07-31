class CreateClocks < ActiveRecord::Migration
  def change
    create_table :clocks do |t|
      t.references :user, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
