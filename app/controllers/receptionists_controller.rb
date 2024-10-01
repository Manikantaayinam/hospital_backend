class ReceptionistsController < ApplicationController
  before_action :authorize_request
  before_action :set_receptionist, only: [:show, :update, :destroy, :restore]

  def index
    @receptionists = @current_user.receptionists.with_deleted.all
    render json: @receptionists, status: :ok
  end

  def create
    @receptionist = @current_user.receptionists.build(receptionist_params)
    @receptionist.status = "active"
    @receptionist.role = "Receptionist"
    if @receptionist.save
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
    @receptionist.update(status: "inactive")
    render json: { message: "Receptionist deactivated successfully" }, status: :ok
  end

  def restore
    @receptionist.update(status: "active")
    @receptionist.restore
    render json: { receptionist: @receptionist, message: 'Receptionist was successfully restored.' }, status: :ok
  end

  private

  def receptionist_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :profile)
  end

  def set_receptionist
    @receptionist = @current_user.receptionists.with_deleted.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Receptionist not found" }, status: :not_found
  end
end
