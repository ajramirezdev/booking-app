class AvailabilitiesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @availabilities = Availability.includes(:table, :time_slot).all.order("id DESC").page(params[:page]).per(5)
  end

  def new
    @availability = Availability.new
  end

  def create
    table_ids = params[:table_ids]
    time_slot_id = params[:availability][:time_slot_id]
    date = params[:availability][:date]

    # Check if table_ids are selected
    if table_ids.blank?
      flash[:alert] = "Please select at least one table."
      @availability = Availability.new
      return render :new, status: :unprocessable_entity
    end

    # Check if time_slot_id and date are provided
    if time_slot_id.blank?
      flash[:alert] = "Please select a time slot."
      @availability = Availability.new
      return render :new, status: :unprocessable_entity
    elsif date.blank?
      flash[:alert] = "Please select a date."
      @availability = Availability.new
      return render :new, status: :unprocessable_entity
    end


      table_ids.each do |table_id|
        Availability.create!(time_slot_id: time_slot_id, table_id: table_id, date: date)
      end

      redirect_to availabilities_path, notice: "Availabilities were successfully created."
  end

  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy
    redirect_to availabilities_path, notice: "Availability was successfully deleted."
  end

  private

    def availability_params
      params.require(:availability).permit(:table_id, :time_slot_id, :date)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def logged_in_user
      redirect_to login_url unless logged_in?
    end
end
