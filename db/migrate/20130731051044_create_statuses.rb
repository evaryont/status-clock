class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :text
      t.integer :lcd
      t.references :user, index: true

      t.timestamps
    end
  end
end
