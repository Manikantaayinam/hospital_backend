class PatientsController < ApplicationController

	before_action :authorize_request
	def index 

	hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @nurses = hospital.patients.all
    render json: @nurses, status: :ok
	end
end
