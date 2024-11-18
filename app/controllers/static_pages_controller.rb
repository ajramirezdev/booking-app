class StaticPagesController < ApplicationController
  def home
    start_date = params.fetch(:start_date, Date.today).to_date
    @availabilities = Availability.includes(:table, :time_slot)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @reservations = Reservation.includes(:table, :time_slot, :availability, :user)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def weekly
    start_date = params.fetch(:start_date, Date.today).to_date
    @availabilities = Availability.includes(:table, :time_slot)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @reservations = Reservation.includes(:table, :time_slot, :availability, :user)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def daily
    start_date = params.fetch(:start_date, Date.today).to_date
    @availabilities = Availability.includes(:table, :time_slot)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @reservations = Reservation.includes(:table, :time_slot)
                              .where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @date = params[:start_date]
    @availabilities_today = Availability.where(date: @date, available: true)
    @time_slots = @availabilities_today.map(&:time_slot).uniq

    @reservations_today = Reservation.includes(:table, :time_slot, :user)
                               .where(date: @date).page(params[:page]).per(5)
  end
end
