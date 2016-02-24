class CreateBiographyEventsTypeTags < ActiveRecord::Migration
  def change
    create_table :biography_events_type_tags do |t|
      t.integer :biography_event_id
      t.integer :type_tag_id
    end
  end
end
