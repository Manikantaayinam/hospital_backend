class ReceptionistsController < ApplicationController
  before_action :authorize_request
  before_action :set_receptionist, only: [:show, :update, :destroy]

  def index
    @receptionists = @current_user.receptionists.all
    render json: @receptionists, status: :ok
  end

  def create
    @receptionist = @current_user.receptionists.create(receptionist_params)
    if @receptionist.save
      @receptionist.update(role: "Receptionist")
      render json: { message: "Receptionist created successfully", account: @receptionist }, status: :created
    else
      render json: { errors: "Failed to create receptionist", errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @receptionist, status: :ok
  end

  def update
    if @receptionist.update(receptionist_params)
      render json: { message: "Receptionist updated successfully", account: @receptionist }, status: :ok
    else
      render json: { errors: "Failed to update receptionist", errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @receptionist.destroy
      render json: { message: "Receptionist deleted successfully" }, status: :ok
    else
      render json: { errors: "Failed to delete receptionist" }, status: :unprocessable_entity
    end
  end

  private

  def receptionist_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number)
  end

  def set_receptionist
    @receptionist = @current_user.receptionists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Receptionist not found" }, status: :not_found
  end
end
