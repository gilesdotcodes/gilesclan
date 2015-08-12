class CalendarItem < ActiveRecord::Base

  belongs_to :user

  scope :west_ham, -> { where('event_type LIKE ?', 'west_ham') }
  scope :descending, -> { order('date_of_event ASC', 'time_of_event ASC')}

end
