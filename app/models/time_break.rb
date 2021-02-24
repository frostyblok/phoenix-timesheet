class TimeBreak < ApplicationRecord
  belongs_to :time_sheet

  validate :validate_time_overlap
  validates :name, :start_time, :end_time, presence: true

  def validate_time_overlap
    time_sheet = self.time_sheet
    new_break_slot = start_time..end_time

    overlap_timebreak = time_sheet.time_breaks.any? {|time_break| new_break_slot.overlaps?(time_break.start_time..time_break.end_time) }
    self.errors.add(:base, "Time breaks can't overlap") if overlap_timebreak
  end
end
