class BookController < ApplicationController
  def show
    @date = Date.parse(params[:date])
    @availabilities = Availability.where(date: @date, available: true)
    @time_slots = @availabilities.map(&:time_slot).uniq
  end
end
