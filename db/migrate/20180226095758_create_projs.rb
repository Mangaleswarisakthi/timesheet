class CreateProjs < ActiveRecord::Migration[5.1]
  def change
    create_table :projs do |t|

      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
