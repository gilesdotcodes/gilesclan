class CreatePersonTags < ActiveRecord::Migration
  def change
    create_table :person_tags do |t|
      t.string :name
    end
  end
end
