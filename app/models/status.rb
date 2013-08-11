class Status < ActiveRecord::Base
  DEFAULTS = %w[Home Work School Sleep Games Shopping Flying]

  belongs_to :user
  belongs_to :clock

  def to_s
    if lcd.nil?
      "#{text}"
    else
      "#{text} [#{lcd}]"
    end
  end
end
