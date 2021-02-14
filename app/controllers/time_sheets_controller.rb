class TimeSheetsController < ApplicationController
  include Timeable

  before_action :set_employee
  before_action :set_timesheet, except: [:create]

  def create
    timesheet = @employee.time_sheets.create!(timesheet_params)

    render_timesheet(timesheet, :created)
  end

  def show
    render_timesheet(@timesheet, :ok)
  end

  def update
    @timesheet.update(timesheet_params)

    render_timesheet(@timesheet, :ok)
  end

  def destroy
    @timesheet.destroy
    head :no_content
  end

  private

  def render_timesheet(timesheet, status)
    render json: {
      id: timesheet.id,
      employee_id: timesheet.employee_id,
      billable_rate: timesheet.billable_rate,
      company: timesheet.company,
      date: timesheet.date,
      start_time: format_to_24_hour_time(timesheet.start_time),
      end_time: format_to_24_hour_time(timesheet.end_time)
    }, status: status
  end

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
