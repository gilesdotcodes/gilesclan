class CalendarItem < ActiveRecord::Base

  belongs_to :user

  scope :current, -> { where('date_of_event >= ?', Date.today)}
  scope :west_ham, -> { where('event_type LIKE ?', 'west_ham') }
  scope :portugal, -> { where('event_type LIKE ?', 'portugal') }
  scope :england, -> { where('event_type LIKE ?', 'england') }
  scope :descending, -> { order('date_of_event ASC', 'time_of_event ASC')}

end
