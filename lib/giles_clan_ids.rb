module GilesClanIds

  def get_giles_clan_ids(event)
    return nil if event.person_tags.empty?
    ids = []
    event.person_tags.each do |person|
      user = User.find_by(first_name: person.name)
      ids << user.id unless user.nil?
    end
    ids
  end

end
