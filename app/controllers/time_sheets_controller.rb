class TimeSheetsController < ApplicationController
  def create
    employee = Employee.find(params[:employee_id])
    timesheets = employee.time_sheets.create!(timesheet_params)

    render json: {
      employee_id: employee.id,
      billable_rate: timesheets.billable_rate,
      company: timesheets.company,
      date: timesheets.date,
      start_time: timesheets.start_time.strftime('%H:%M'),
      end_time: timesheets.end_time.strftime('%H:%M')
    }, status: 201

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    render json: { error: e.message }
  end

  private

  def timesheet_params
    params.permit(:billable_rate, :company, :date, :start_time, :end_time)
  end
end
