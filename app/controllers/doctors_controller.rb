class DoctorsController < ApplicationController
	before_action :authorize_request
	def index
		@doctors = @current_user.doctors.all
		render json: @doctors, status: :ok
	end
	def create
		@doctor = @current_user.doctors.create(doctor_params)
		if @doctor.save
			@doctor.update(role: "Doctor")
			 render json: { messages: "Doctor Created Sucessfully", account: @doctor }, status: :created
		else
			 render json: { errors: "Failed to create doctor", errors: @doctor.errors.full_messages }, status: :unprocessable_entity
		end
	end
	private
	def doctor_params
			params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :specialist_in)
	end

end
