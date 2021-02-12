class TimeSheetsController < ApplicationController
  before_action :set_employee
  before_action :set_timesheet, except: [:create]

  def create
    timesheet = @employee.time_sheets.create!(timesheet_params)

    render json: {
      id: timesheet.id,
      employee_id: timesheet.employee_id,
      billable_rate: timesheet.billable_rate,
      company: timesheet.company,
      date: timesheet.date,
      start_time: timesheet.start_time.strftime('%H:%M'),
      end_time: timesheet.end_time.strftime('%H:%M')
    }, status: :created
  end

  def show
    render json: {
      id: @timesheet.id,
      employee_id: @timesheet.employee_id,
      billable_rate: @timesheet.billable_rate,
      company: @timesheet.company,
      date: @timesheet.date,
      start_time: @timesheet.start_time.strftime('%H:%M'),
      end_time: @timesheet.end_time.strftime('%H:%M')
    }, status: :ok
  end

  def update
    @timesheet.update(timesheet_params)

    render json: {
      id: @timesheet.id,
      employee_id: @timesheet.employee_id,
      billable_rate: @timesheet.billable_rate,
      company: @timesheet.company,
      date: @timesheet.date,
      start_time: @timesheet.start_time.strftime('%H:%M'),
      end_time: @timesheet.end_time.strftime('%H:%M')
    }, status: :ok
  end

  def destroy
    @timesheet.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_timesheet
    @timesheet = @employee.time_sheets.find(params[:id])
  end

  def timesheet_params
    params.permit(:billable_rate, :company, :date, :start_time, :end_time)
  end
end
