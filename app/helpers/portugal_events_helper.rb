module PortugalEventsHelper
  def get_portugal_class(year, month, day)
    date =  begin
              Date.new(year, month, day)
            rescue
              nil
            end
    return '' unless date
    events = PortugalEvent.where(event_date: date)
    return '' if events.empty?
    ids = events.pluck(:user_id)
    [].tap do |arr|
      arr << 'mum' if ids.include?(4)
      arr << 'dad' if ids.include?(5)
      arr << 'other' if (ids & [1, 2, 3, 7, 8]).any?
    end.join('_')
  end
end
