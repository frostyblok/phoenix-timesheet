class TimeBreak < ApplicationRecord
  belongs_to :time_sheet

  validate :validate_time_overlap
  validates :name, :start_time, :end_time, presence: true

  scope :timebreaks_for_a_timesheet, -> (timesheet_id) { includes(:time_sheet).where(time_sheet: { id: timesheet_id }) }

  private

  def validate_time_overlap
    return self.errors.add(:base, "Time breaks must be between working hours") unless between_work_hours.overlaps?(new_break_slot)

    overlap_timebreak = TimeBreak.timebreaks_for_a_timesheet(timesheet.id).any? {|time_break| new_break_slot.overlaps?(time_break.start_time..time_break.end_time) }
    self.errors.add(:base, "Time breaks can't overlap") if overlap_timebreak
  end

  def timesheet
    time_sheet
  end

  def new_break_slot
    start_time..end_time
  end

  def between_work_hours
    timesheet.start_time..timesheet.end_time
  end
end
