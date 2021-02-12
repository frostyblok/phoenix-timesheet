require 'rails_helper'

RSpec.describe "TimeSheets", type: :request do
  let!(:employee) { create(:employee) }
  let(:employee_id) { employee.id }

  describe "Create TimeSheet" do
    context "POST" do
      let(:timesheet_attributes) do
        {
          "billable_rate" => 300.0,
          "company" => 'MTN',
          "date" => '2019-08-01',
          "start_time" => '09:00',
          "end_time" => '17:00'
        }
      end
      before { post "/employees/#{employee_id}/time_sheets", params: timesheet_attributes }

      context 'wtih valid timesheet attributes' do

        it 'successfully creates employee\'s timesheet' do
          expect(json_response['employee_id']).to eq(employee.id)
          expect(json_response['billable_rate'].to_f).to eq(timesheet_attributes['billable_rate'])
          expect(json_response['company']).to eq(timesheet_attributes['company'])
          expect(json_response['date']).to eq(timesheet_attributes['date'])
          expect(json_response['start_time']).to eq(timesheet_attributes['start_time'])
          expect(json_response['end_time']).to eq(timesheet_attributes['end_time'])
        end
      end

      context 'with missing timesheet attribute' do
        let(:timesheet_attributes) do
          {
            "billable_rate" => 300.0,
            "date" => '2019-08-01',
            "start_time" => '09:00',
            "end_time" => '17:00'
          }
        end

        it 'returns validation error' do
          expect(response.body).to match(/Validation failed: Company can't be blank/)
        end
      end

      context 'when creating timesheet for employee that does not exist' do
        let(:employee_id) { 457849  }

        it 'returns validation error' do
          expect(response.body).to match(/Couldn't find Employee with 'id'/)
        end
      end
    end
  end
end
