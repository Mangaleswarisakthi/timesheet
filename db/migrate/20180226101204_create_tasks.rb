class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
t.integer :proj_id
t.date :taskdate
      t.string :title
t.string :desc
t.decimal :duration, precision: 4, scale: 2
      t.timestamps
    end
  end
end
