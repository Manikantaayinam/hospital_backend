class DoctorsController < ApplicationController
  before_action :authorize_request
  before_action :set_doctor, only: [:show, :update, :destroy, :restore]

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @doctors = hospital.doctors.with_deleted.all
    render json: @doctors, status: :ok
  end

  def create
    @doctor = @current_user.doctors.build(doctor_params)
    @doctor.status = "active"
    @doctor.role = "Doctor"
    if @doctor.save
      render json: { message: "Doctor created successfully", account: @doctor }, status: :created
    else
      render json: { errors: "Failed to create doctor", errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @doctor, status: :ok
  end

  def update
    if @doctor.update(doctor_params)
      render json: { message: "Doctor updated successfully", account: @doctor }, status: :ok
    else
      render json: { errors: "Failed to update doctor", errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.update(status: "inactive")
    render json: { message: "Doctor deactivated successfully" }, status: :ok
  end

  def restore
    @doctor.update(status: "active")
    @doctor.restore
    render json: { doctor: @doctor, message: 'Doctor was successfully restored.' }, status: :ok
  end

  private

  def doctor_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :specialist_in, :profile)
  end

  def set_doctor
    @doctor = @current_user.doctors.with_deleted.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Doctor not found" }, status: :not_found
  end
end
