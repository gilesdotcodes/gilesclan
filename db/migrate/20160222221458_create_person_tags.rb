class CreatePersonTags < ActiveRecord::Migration[5.2]
  def change
    create_table :person_tags do |t|
      t.string :name
    end
  end
end
