class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  GILES_CLAN_IDS = {
    1 => 'Stephen',
    2 => 'Emma',
    3 => 'David',
    4 => 'Adrian',
    5 => 'Carol',
    7 => 'James',
    8 => 'Arthur',
    9 => 'Lucy'
  }

  GILES_EMAIL_IDS = [1, 2, 3, 4, 5, 9]

  scope :giles_clan, ->{ where(id: GILES_CLAN_IDS.keys) }
  scope :giles_clan_email, ->{ where(id: GILES_EMAIL_IDS) }
  scope :linked_giles_clan, ->(first_names) { where(first_name: first_names) }

  def fullname
    "#{first_name} #{last_name}"
  end
end
