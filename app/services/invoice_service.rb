class InvoiceService
  attr_reader :timesheets

  SECONDS_TO_HOURS_RATIO = 3600

  def initialize(timesheets)
    @timesheets = timesheets
  end

  def invoices_and_total_cost
    total_cost = 0

    invoices = timesheets.map do |timesheet|
      cost = timesheet_attributes(timesheet)[:unit_price] * number_of_hours(timesheet_attributes(timesheet)[:start_time], timesheet_attributes(timesheet)[:end_time])
      total_cost += cost

      invoice(timesheet, cost)
    end

    [invoices, total_cost]
  end

  private

  def invoice(timesheet, cost)
    {
      employee_id: timesheet_attributes(timesheet)[:employee_id],
      number_of_hours: number_of_hours(timesheet_attributes(timesheet)[:start_time], timesheet_attributes(timesheet)[:end_time]),
      unit_price: timesheet_attributes(timesheet)[:unit_price],
      cost: cost
    }
  end

  def number_of_hours(start_time, end_time)
    (Time.parse(end_time.strftime('%H:%M')) - Time.parse(start_time.strftime('%H:%M')))/SECONDS_TO_HOURS_RATIO
  end

  def timesheet_attributes(timesheet)
    {
      employee_id: timesheet.employee_id,
      start_time: timesheet.start_time,
      end_time: timesheet.end_time,
      unit_price: timesheet.billable_rate
    }
  end
end
