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
      let(:timebreak_attributes) do
        {
          "time_breaks" => {
            "0" => {
            "name" => 'Lunch',
            "start_time" => '12:00',
            "end_time" => '13:00',
            },
            "1" => {
              "name" => 'Gist',
              "start_time" => '13:05',
              "end_time" => '14:0',
            },
          }
        }
      end
      before { post "/employees/#{employee_id}/time_sheets", params: timesheet_attributes.merge(timebreak_attributes) }

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

      context 'when overlapping time' do
        let(:timebreak_attributes) do
          {
            "time_breaks" => {
              "0" => {
                "name" => 'Lunch',
                "start_time" => '22:00',
                "end_time" => '23:00',
              },
              "1" => {
                "name" => 'Gist',
                "start_time" => '22:00',
                "end_time" => '23:00',
              },
            }
          }
        end

        it 'returns validation error' do
          expect(response.body).to match(/Validation failed: Time breaks can't overlap/)
        end
      end

      context 'when creating timesheet for employee that does not exist' do
        let(:employee_id) { 457849 }

        it 'returns validation error' do
          expect(response.body).to match(/Couldn't find Employee with 'id'/)
        end
      end
    end
  end

  describe "View timesheet" do
    let(:employee) { create(:employee) }
    let(:employee_id) { employee.id }
    let!(:timesheet) { create(:time_sheet, employee_id: employee_id) }
    let(:timesheet_id) { timesheet.id }

    before { get "/employees/#{employee_id}/time_sheets/#{timesheet_id}" }

    context "when timesheet exists" do
      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end
      it 'returns timesheet' do
        expect(json_response['id']).to eq(timesheet.id)
        expect(json_response['employee_id']).to eq(timesheet.employee_id)
      end
    end

    context 'when timesheet does not exist' do
      let(:timesheet_id) { 532 }

      it 'returns error' do
        expect(response.body).to match(/Couldn't find TimeSheet with 'id'/)
      end
    end

    describe 'Update timesheet' do
      let(:timesheet_attribute) { { billable_rate: 500 } }

      before { put "/employees/#{employee_id}/time_sheets/#{timesheet_id}", params: timesheet_attribute }

      context 'when item exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
          expect(json_response['billiable_rate']).to eq(timesheet_attribute['billable_rate'])
        end
      end

      context 'when timesheet does not exist' do
        let(:timesheet_id) { 938 }

        it 'return error' do
          expect(response.body).to match(/Couldn't find TimeSheet with 'id'/)
        end
      end
    end

    describe 'Delete timesheet' do
      before { delete "/employees/#{employee_id}/time_sheets/#{timesheet_id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'successfully deletes record' do
        expect { TimeSheet.find(timesheet_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
