class BiographyEvent < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :person_tags
  has_and_belongs_to_many :type_tags

  scope :latest_first, -> { order('start_date DESC') }
  scope :oldest_first, -> { order('start_date ASC') }
  scope :this_month, -> { where("DATE_PART('month', start_date) = ?", Time.zone.now.month) }
  scope :on_this_day, -> { where("DATE_PART('month', start_date) = ? AND DATE_PART('day', start_date) = ?", Time.zone.now.month, Time.zone.now.day) }
  scope :by_year, ->(year) { where("DATE_PART('year', start_date) = ?", year) }
  scope :by_type, ->(ids) { joins(:type_tags).where('type_tags.id IN (?)', ids) }
  scope :by_person, ->(ids) { joins(:person_tags).where('person_tags.id IN (?)', ids) }

  validates :start_date, :title, presence: true

  def date_output
    return start_date.strftime("%a %e %b %Y") if end_date.nil?
    "#{start_date.strftime("%a %e %b")} - #{end_date.strftime("%a %e %b %Y")}"
  end

  def self.years
    years = []
    self.latest_first.each do |be|
      years << be.start_date.year
    end
    years.uniq
  end

  def self.send_random_notification
    offset = rand(BiographyEvent.count)
    event = BiographyEvent.offset(offset).first
    Notifications.random_biography_event_mailer(event).deliver
  end

  def self.send_daily_notification
    event = BiographyEvent.on_this_day.shuffle.first
    return false if event.nil?
    Notifications.daily_biography_event_mailer(event).deliver
  end

  def self.send_daily_summary_notification
    events = BiographyEvent.on_this_day.oldest_first
    return false if events.empty?
    Notifications.daily_summary_event_mailer(events).deliver
  end

  def types_to_s
    return if type_tags.empty?
    count = type_tags.size
    str = ''
    type_tags.each_with_index do |type, i|
      str << type.name
      str << ', ' unless i+1 == count
    end
    str
  end
end
