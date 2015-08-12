class CreateCalendarItems < ActiveRecord::Migration
  def change
    create_table :calendar_items do |t|

      t.date :date_of_event
      t.time :time_of_event
      t.string :event_type
      t.string :name
      t.string :location
      t.text :note

      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
