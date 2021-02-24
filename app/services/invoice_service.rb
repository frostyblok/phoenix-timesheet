class InvoiceService
  include Timeable

  attr_reader :timesheets

  SECONDS_TO_HOURS_RATIO = 3600

  def initialize(timesheets)
    @timesheets = timesheets
  end

  def invoices_and_total_cost
    total_cost = 0

    invoices = timesheets.map do |timesheet|
      timebreaks = timesheet.time_breaks

      cost = timesheet_cost(timesheet, timebreaks)
      total_cost += cost

      invoice(timesheet, cost, timebreaks)
    end

    [invoices, total_cost]
  end

  private

  def invoice(timesheet, cost, timebreaks)
    {
      employee_id: timesheet_attributes(timesheet)[:employee_id],
      number_of_hours: total_number_of_hours(timesheet, timebreaks),
      unit_price: timesheet_attributes(timesheet)[:unit_price],
      cost: cost
    }
  end

  def timesheet_cost(timesheet, timebreaks)
    timesheet_attributes(timesheet)[:unit_price] * total_number_of_hours(timesheet, timebreaks)
  end

  def total_number_of_hours(timesheet, timebreaks)
    number_of_hours(
      timesheet_attributes(timesheet)[:start_time],
      timesheet_attributes(timesheet)[:end_time]
    ) - total_timebreak(timebreaks)
  end


  def number_of_hours(start_time, end_time)
    (Time.parse(format_to_24_hour_time(end_time)) - Time.parse(format_to_24_hour_time(start_time)))/SECONDS_TO_HOURS_RATIO
  end

  def timesheet_attributes(timesheet)
    {
      employee_id: timesheet.employee_id,
      start_time: timesheet.start_time,
      end_time: timesheet.end_time,
      unit_price: timesheet.billable_rate
    }
  end

  def total_timebreak(timebreaks)
    timebreaks.reduce(0) { |sum, timebreak| sum + number_of_hours(timebreak.start_time, timebreak.end_time) }
  end
end
