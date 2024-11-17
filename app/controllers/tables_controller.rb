class TablesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_table, only: %i[show edit update destroy]

  def index
    @tables = Table.all.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    if @table.save
      redirect_to tables_path, notice: "Table was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @table.update(table_params)
      redirect_to tables_path, notice: "Table was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @table.destroy
    redirect_to tables_path, notice: "Table was successfully deleted."
  end

  private

  def set_table
    @table = Table.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :max_capacity)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def logged_in_user
    redirect_to login_url unless logged_in?
  end
end
