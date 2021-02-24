class CreateTimeBreaks < ActiveRecord::Migration[6.1]
  def change
    create_table :time_breaks do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.references :time_sheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
