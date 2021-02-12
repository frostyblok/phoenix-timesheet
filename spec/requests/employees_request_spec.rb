require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let(:employee_attribute) { { name: 'Justin Sand' } }

  context "POST employee" do
    before { post "/employees", params: employee_attribute }

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end
end
