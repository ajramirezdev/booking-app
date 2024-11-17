class StaticPagesController < ApplicationController
  def home
    start_date = params.fetch(:start_date, Date.today).to_date
    @availabilities = Availability.includes(:table, :time_slot)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
