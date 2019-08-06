class CreateTypeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :type_tags do |t|
      t.string :name
    end
  end
end
