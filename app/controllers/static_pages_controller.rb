class StaticPagesController < ApplicationController
  def home
    @time_slots = TimeSlot.all
  end
end
