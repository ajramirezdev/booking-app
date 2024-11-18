class ReservationsController < ApplicationController
  before_action :logged_in_user
  before_action :set_reservation, only: [ :show, :edit, :update, :destroy ]
  before_action :admin_user, only: [ :index, :edit, :update, :destroy ]

  def index
    @reservations = Reservation.includes(:user, :table, :time_slot, :availability).all.order(:date).page(params[:page]).per(5)
  end

  def new
    @reservation = Reservation.new
    @table_id = params[:table_id]
    @time_slot_id = params[:time_slot_id]
    @availability_id = params[:availability_id]
    @date = params[:date]
    @table = Table.find(params[:table_id])
    @time_slot = TimeSlot.find(params[:time_slot_id])
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)

    availability = Availability.find_by(
      table_id: @reservation.table_id,
      time_slot_id: @reservation.time_slot_id,
      date: @reservation.date
    )

    if availability && availability.available?
      availability.update(available: false)

      if @reservation.save
        redirect_to @reservation, notice: "Reservation was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else

      flash.now[:alert] = "This table is no longer available for the selected time slot."
      prepare_form_data
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @table = @reservation.table
    @time_slot = @reservation.time_slot
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "Reservation was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    availability = Availability.find_by(
        table_id: @reservation.table_id,
        time_slot_id: @reservation.time_slot_id,
        date: @reservation.date
      )
    availability.update(available: true)
    if @reservation.destroy
      redirect_to reservations_path, notice: "Reservation was successfully deleted."
    else
      redirect_to reservations_path, alert: "There was an error deleting your reservation."
    end
  end

  def my_reservations
    @reservations = current_user.reservations.order(:date).page(params[:page]).per(5)
  end

  def cancel
    @reservation = current_user.reservations.find(params[:id])

    if @reservation.update(status: "cancelled")
      availability = Availability.find_by(
        table_id: @reservation.table_id,
        time_slot_id: @reservation.time_slot_id,
        date: @reservation.date
      )

      if availability.present?
        availability.update(available: true)
      end

      redirect_to my_reservations_path, notice: "Reservation was successfully cancelled."
    else
      redirect_to my_reservations_path, alert: "There was an error cancelling your reservation."
    end
  end

  def by_date
    @date = params[:date]
    @reservations = Reservation.includes(:table, :time_slot, :user)
                               .where(date: @date).page(params[:page]).per(5)
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(
      :user_id,
      :table_id,
      :time_slot_id,
      :availability_id,
      :date,
      :number_of_people,
      :status
    )
  end

  def logged_in_user
    redirect_to login_url unless logged_in?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
