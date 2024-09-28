class DoctorsController < ApplicationController
  before_action :authorize_request
  before_action :set_doctor, only: [:show, :update, :destroy]

  # List all doctors
  def index
    @doctors = @current_user.doctors.all
    render json: @doctors, status: :ok
  end

  # Create a new doctor
  def create
    @doctor = @current_user.doctors.create(doctor_params)
    if @doctor.save
      @doctor.update(role: "Doctor")
      render json: { message: "Doctor created successfully", account: @doctor }, status: :created
    else
      render json: { errors: "Failed to create doctor", errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Show a specific doctor
  def show
    render json: @doctor, status: :ok
  end

  # Update a doctor's information
  def update
    if @doctor.update(doctor_params)
      render json: { message: "Doctor updated successfully", account: @doctor }, status: :ok
    else
      render json: { errors: "Failed to update doctor", errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete a doctor
  def destroy
    if @doctor.destroy
      render json: { message: "Doctor deleted successfully" }, status: :ok
    else
      render json: { errors: "Failed to delete doctor" }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :specialist_in, :profile)
  end

  def set_doctor
    @doctor = @current_user.doctors.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Doctor not found" }, status: :not_found
  end
end
