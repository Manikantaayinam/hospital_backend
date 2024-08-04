class DoctorsController < ApplicationController

	before_action :authorize_request

	def create

		@doctor = Doctor.create(doctor_params)
		if @doctor.save
			 render json: { messages: "Doctor Created Sucessfully", account: @doctor }, status: :created
		else
			 render json: { errors: "Failed to create doctor" }, status: :unprocessable_entity
		end

	end

	private
		def doctor_params
			
			params.require.permit(:name, :email, :password, :password_confirmation, :location, :phone_number, :specialist_in)
		end

end
