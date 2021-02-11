class EmployeesController < ApplicationController
  def create
    employee = Employee.create!(employee_param)
    render json: { employee: employee }, status: 201
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }
  end

  private

  def employee_param
    params.permit(:name)
  end
end
