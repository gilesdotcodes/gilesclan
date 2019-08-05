class Notifications < ApplicationMailer
  include GilesClanIds

  def random_biography_event_mailer(event)
    @event = event
    @giles_clan_ids = User.linked_giles_clan(@event.person_tags.pluck(:name)).pluck(:id)
    mail(
      to: User.where('id IN (?)',(1..5)).pluck(:email),
      subject: "Giles Clan: A Random Memory from #{@event.start_date.year}"
    )
  end

  def daily_biography_event_mailer(event)
    @event = event
    @giles_clan_ids = User.linked_giles_clan(@event.person_tags.pluck(:name)).pluck(:id)
    mail(
      to: User.where('id IN (?)',(1..5)).pluck(:email),
      subject: "Giles Clan: On This Day in #{@event.start_date.year}"
    )
  end

  def daily_summary_event_mailer(events)
    @events = events
    mail(
      to: User.where('id IN (?)',(1..5)).pluck(:email),
      subject: "Giles Clan History for #{Date.today.strftime('%e %b').strip}"
    )
  end
end
