class AddBiographyEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :biography_events do |t|

      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.text :description
      t.string :location

      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
