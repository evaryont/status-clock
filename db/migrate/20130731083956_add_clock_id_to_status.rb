class AddClockIdToStatus < ActiveRecord::Migration
  def change
    add_reference :statuses, :clock, index: true
  end
end
