class Notifications < ApplicationMailer

  def west_ham_mailer(item, users)
    @calendar_item = item
    mail(
      to: users,
      subject: "West Ham Fixture: #{@calendar_item.name}"
    )
  end

end
