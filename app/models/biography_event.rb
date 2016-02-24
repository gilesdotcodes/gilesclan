class BiographyEvent < ActiveRecord::Base

  belongs_to :user

  has_and_belongs_to_many :person_tags
  has_and_belongs_to_many :type_tags

  scope :this_month, -> { where("DATE_PART('month', start_date) = ?", Time.zone.now.month) }
  scope :latest_first, -> { order('start_date DESC') }
  scope :types, ->(ids) { joins(:type_tags).where('type_tags.id IN (?)', ids) }
  scope :persons, ->(ids) { joins(:person_tags).where('person_tags.id IN (?)', ids) }

  validates :start_date, :title, presence: true

  def date_output
    return start_date.strftime("%a %e %b %Y") if end_date.nil?
    "#{start_date.strftime("%a %e %b")} - #{end_date.strftime("%a %e %b %Y")}"
  end

end
