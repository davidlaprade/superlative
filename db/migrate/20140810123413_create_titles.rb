class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.integer :user_id
      t.string :content
      t.integer :created_by
      t.timestamps
    end
  end
end
