module PortugalEventsHelper
  def get_portugal_date_variables(year, month, day)
    date =  begin
              Date.new(year, month, day)
            rescue
              nil
            end
    return ['empty', nil, date] unless date
    user_ids = PortugalEvent.where(event_date: date).pluck(:user_id)
    return ['empty', nil, date] if user_ids.empty?
    klass = [].tap do |arr|
              arr << 'mum' if user_ids.include?(5)
              arr << 'dad' if user_ids.include?(4)
              arr << 'other' if (user_ids & [1, 2, 3, 7, 8]).any?
            end.join('_')
    [klass, user_ids, date]
  end
end
