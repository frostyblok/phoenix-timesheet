class AddIndexToTimeSheets < ActiveRecord::Migration[6.1]
  def change
    add_index :time_sheets, :company
  end
end
