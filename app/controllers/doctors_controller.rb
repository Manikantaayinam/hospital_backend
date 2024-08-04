class DoctorsController < ApplicationController
	before_action :authorize_request
	before_action :set_doctor, only: [:show, :update, :destroy]
  
	def index
	  @doctors = Doctor.all
	  render json: @doctors
	end
  
	def show
	  render json: @doctor
	end
  
	def create
	  @doctor = Doctor.new(doctor_params)
	  if @doctor.save
		render json: { message: "Doctor created successfully", account: @doctor }, status: :created
	  else
		render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
	  end
	end
  
	def update
	  if @doctor.update(doctor_params)
		render json: { message: "Doctor updated successfully", account: @doctor }
	  else
		render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
	  end
	end
  
	def destroy
	  @doctor.destroy
	  render json: { message: "Doctor deleted successfully" }, status: :no_content
	end
  
	private
  
	def set_doctor
	  @doctor = Doctor.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  render json: { error: "Doctor not found" }, status: :not_found
	end
  
	def doctor_params
	  params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :role, :specialist_in)
	end
  end
  