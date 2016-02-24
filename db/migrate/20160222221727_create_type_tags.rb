class CreateTypeTags < ActiveRecord::Migration
  def change
    create_table :type_tags do |t|
      t.string :name
    end
  end
end
