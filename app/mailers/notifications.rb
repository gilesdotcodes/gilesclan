class Notifications < ApplicationMailer

  def west_ham_mailer(item, users)
    @calendar_item = item
    mail(
      to: users,
      subject: "West Ham Fixture: #{@calendar_item.name}"
    )
  end

  def random_biography_event_mailer(event)
    @event = event
    mail(
      to: User.pluck(:email),
      subject: "Giles Clan: A Random Memory from #{@event.start_date.year}"
    )
  end

  def daily_biography_event_mailer(event)
    @event = event
    mail(
      to: User.pluck(:email),
      subject: "Giles Clan: On This Day in #{@event.start_date.year}"
    )
  end

end
