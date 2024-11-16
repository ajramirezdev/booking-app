class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def new
    @time_slot = TimeSlot.new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_params)

    if @time_slot.save
      redirect_to new_time_slot_path, notice: "TimeSlot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @time_slot.update(time_slot_params)
      redirect_to static_pages_home_path, notice: "Time Slot was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @time_slot.destroy
    redirect_to root_path, notice: "Time Slot was successfully deleted."
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time, :max_tables)
  end

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end
end
