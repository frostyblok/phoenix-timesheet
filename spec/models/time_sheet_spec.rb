require 'rails_helper'

RSpec.describe TimeSheet, type: :model do
  it { should belong_to(:employee) }
  it { should validate_presence_of(:billable_rate) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end
