require 'rails_helper'

RSpec.describe "Invoices", type: :request do
  let!(:first_employee) { create(:employee) }
  let!(:second_employee) { create(:employee) }
  let(:company_name) { 'MTN' }
  let(:first_employee_billable_rate) { 200.0 }
  let(:second_employee_billable_rate) { 300.0 }
  let!(:first_employee_timesheet) { create(:time_sheet, employee_id: first_employee.id, billable_rate: first_employee_billable_rate, company: company_name) }
  let!(:second_employee_timesheet) { create(:time_sheet, employee_id: second_employee.id, billable_rate: second_employee_billable_rate, company: company_name) }
  let(:company_related_timesheet) { [first_employee_timesheet, second_employee_timesheet] }

  context "#generate" do
    let(:first_employee_cost) { first_employee_billable_rate * 8 }
    let(:second_employee_cost) { second_employee_billable_rate * 8 }

    before { get "/invoices/#{company_name}" }

    it 'returns a list of invoices and the total cost for all the invoices' do
      expect(json_response['total_cost'].to_f).to eq(first_employee_cost + second_employee_cost)
      expect(json_response['invoices'].size).to eq(company_related_timesheet.size)
    end
  end
end
