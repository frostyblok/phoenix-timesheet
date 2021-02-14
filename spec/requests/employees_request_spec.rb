require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let(:employee_attribute) { { name: 'Justin Sand' } }

  context "POST employee" do
    before { post "/employees", params: employee_attribute }

    it 'successfully create an employee' do
      expect(response).to have_http_status(201)
      expect(json_response['employee']['name']).to eq(employee_attribute[:name])
    end
  end
end
