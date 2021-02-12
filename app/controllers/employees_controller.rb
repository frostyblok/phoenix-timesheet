class EmployeesController < ApplicationController
  def create
    employee = Employee.create!(employee_param)
    render json: { employee: employee }, status: :created
  end

  private

  def employee_param
    params.permit(:name)
  end
end
