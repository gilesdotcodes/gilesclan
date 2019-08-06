class CreateBiographyEventsPersonTags < ActiveRecord::Migration[5.2]
  def change
    create_table :biography_events_person_tags do |t|
      t.integer :biography_event_id
      t.integer :person_tag_id
    end
  end
end
