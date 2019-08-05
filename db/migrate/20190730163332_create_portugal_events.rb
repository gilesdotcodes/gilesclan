class CreatePortugalEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :portugal_events do |t|
      t.integer :user_id
      t.date :event_date

      t.timestamps
    end
  end
end
