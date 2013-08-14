class Clock < ActiveRecord::Base
  has_many :users
  has_many :statuses

  # Create a new clock, along with a number of statuses. These new statuses will
  # serve to be the initial statuses displayed on the clock.
  def self.init_with_statuses(from_user, lcd_count = 6)
    Rails.logger.debug "Creating a new clock for #{from_user} with #{lcd_count} statuses"
    new_clock = Clock.new
    new_clock.statuses = (0..(lcd_count.to_i-1)).map do |lcd_position|
      default_status = Status.new
      default_status.text = Status::DEFAULTS[lcd_position]
      default_status.lcd = lcd_position
      default_status.save!
      default_status
    end
    new_clock.users = [from_user]
    new_clock.save!

    from_user.clock_id = new_clock.id
    from_user.status_id = new_clock.statuses[0].id
    from_user.clock = new_clock
    from_user.status = new_clock.statuses[0]
    from_user.hand = 1
    from_user.save!
  end

  module SortedStatuses
    # Returns the same data as before, but sorts the list of statuses by their LCD
    # number. (Intending so that the status with LCD 0 is at the top of the list.)
    def statuses
      super.sort_by do |status|
        status.lcd
      end
    end
  end

  include SortedStatuses
end

