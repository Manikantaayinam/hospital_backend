class ReceptionistsController < ApplicationController

	before_action :authorize_request
	def index
	end
	def create
		@receptionist = @current_user.receptionists.create(receptionist_params)
		if @receptionist.save
			@receptionist.update(role: "Receptionist")
			 render json: { messages: "Receptionist Created Sucessfully", account: @receptionist }, status: :created
		else
			 render json: { errors: "Failed to create Receptionist", errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private
	def receptionist_params
			params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :role)
	end
end
