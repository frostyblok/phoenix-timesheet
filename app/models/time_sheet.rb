class TimeSheet < ApplicationRecord
  belongs_to :employee

  validates :billable_rate, :company, :date, :start_time, :end_time, presence: true
end
