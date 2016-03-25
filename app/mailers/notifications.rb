require 'giles_clan_ids'
class Notifications < ApplicationMailer

  include GilesClanIds

  def west_ham_mailer(item, users)
    @calendar_item = item
    mail(
      to: users,
      subject: "West Ham Fixture: #{@calendar_item.name}"
    )
  end

  def random_biography_event_mailer(event)
    @event = event
    @giles_clan_ids = get_giles_clan_ids(@event)
    mail(
      # to: User.where('id IN (?)',(1..6)).pluck(:email),
      to: 's.giles@hotmail.co.uk'
      subject: "Giles Clan: A Random Memory from #{@event.start_date.year}"
    )
  end

  def daily_biography_event_mailer(event)
    @event = event
    @giles_clan_ids = get_giles_clan_ids(@event)
    mail(
      to: User.where('id IN (?)',(1..6)).pluck(:email),
      subject: "Giles Clan: On This Day in #{@event.start_date.year}"
    )
  end

end
