class Clock < ActiveRecord::Base
  has_many :users
  has_many :statuses

  # Create a new clock, along with a number of statuses. These new statuses will
  # serve to be the initial statuses displayed on the clock.
  def self.init_with_statuses(from_user, lcd_count = 6)
    new_clock = Clock.new
    new_clock.statuses = (0..(lcd_count-1)).map do |lcd_position|
      default_status = Status.new
      default_status.text = Status::DEFAULTS[lcd_position]
      default_status.lcd = lcd_position
      default_status.save!
      default_status
    end
    new_clock.users = [from_user]
    new_clock.save!

    from_user.clock = new_clock
    from_user.save!
  end
end
