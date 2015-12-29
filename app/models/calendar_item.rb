class CalendarItem < ActiveRecord::Base

  belongs_to :user

  scope :current, -> { where('date_of_event >= ?', Date.today)}
  scope :west_ham, -> { where('event_type LIKE ?', 'west_ham') }
  scope :portugal, -> { where('event_type LIKE ?', 'portugal') }
  scope :england, -> { where('event_type LIKE ?', 'england') }
  scope :descending, -> { order('date_of_event ASC', 'time_of_event ASC')}

  after_save :send_notification

  def send_notification
    west_ham_notification if event_type == 'west_ham' && changed?
  end

  private

  def west_ham_notification
    Notifications.west_ham_mailer(self, west_ham_emails).deliver
  end

  def west_ham_emails
    User.where(id: [1,3,4]).pluck(:email)
  end

end
