class TimeSheet < ApplicationRecord
  belongs_to :employee
  has_many :time_breaks, dependent: :destroy

  validates :billable_rate, :company, :date, :start_time, :end_time, presence: true
end
