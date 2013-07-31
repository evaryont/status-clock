class Status < ActiveRecord::Base
  belongs_to :user

  def to_s
    if lcd.nil?
      "#{text}"
    else
      "#{text} [#{lcd}]"
    end
  end
end
