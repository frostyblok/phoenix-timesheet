require 'rails_helper'

RSpec.describe InvoiceService do
  let(:employee) { create(:employee) }
  let(:billable_rate) { 300.0 }
  let(:timesheets) { create_list(:time_sheet, 3, billable_rate: billable_rate, employee_id: employee.id) }
  subject { described_class.new timesheets }

  context "#invoices_and_total_cost" do
    let(:number_of_timesheets) { timesheets.size }
    let(:number_of_hours_for_one_timesheet) { 8 }
    let(:cost_of_an_invoice) { number_of_hours_for_one_timesheet * billable_rate }

    it 'returns an array of invoices and total cost' do
      invoice, total_cost = subject.invoices_and_total_cost

      expect(subject.invoices_and_total_cost).to be_an_instance_of(Array)
      expect(invoice.size).to eq(number_of_timesheets)
      expect(total_cost).to eq(number_of_timesheets * cost_of_an_invoice)
    end
  end
end
