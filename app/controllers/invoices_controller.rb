class InvoicesController < ApplicationController
  def generate
    invoices, total_cost = InvoiceService.new(timesheets).invoices_and_total_cost

    render json: { invoices: invoices, total_cost: total_cost, company_name: params[:company_name] }
  end

  private

  def timesheets
    @timesheets ||= TimeSheet.where(company: params[:company_name])
  end
end
