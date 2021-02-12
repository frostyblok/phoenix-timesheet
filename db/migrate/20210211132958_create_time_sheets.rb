class CreateTimeSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :time_sheets do |t|
      t.decimal :billable_rate
      t.string :company
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
