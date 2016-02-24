class BiographyEvent < ActiveRecord::Base

  belongs_to :user

  has_and_belongs_to_many :person_tags
  has_and_belongs_to_many :type_tags

  scope :latest_first, -> { order('start_date DESC') }
  scope :this_month, -> { where("DATE_PART('month', start_date) = ?", Time.zone.now.month) }
  scope :by_year, ->(year) { where("DATE_PART('year', start_date) = ?", year) }
  scope :by_type, ->(id) { joins(:type_tags).where('type_tags.id = ?', id) }
  scope :by_person, ->(id) { joins(:person_tags).where('person_tags.id = ?', id) }

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

end
