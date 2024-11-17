class TimeSlotsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_time_slot, only: [ :show, :edit, :update, :destroy ]

  def index
    @time_slots = TimeSlot.all.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @time_slot = TimeSlot.new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_params)

    if @time_slot.save
      redirect_to time_slots_path, notice: "TimeSlot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @time_slot.update(time_slot_params)
      redirect_to time_slots_path, notice: "Time Slot was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @time_slot.destroy
    redirect_to time_slots_path, notice: "Time Slot was successfully deleted."
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:start_time, :end_time, :max_tables)
  end

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def logged_in_user
    redirect_to login_url unless logged_in?
  end
end
