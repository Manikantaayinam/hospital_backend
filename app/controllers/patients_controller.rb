class PatientsController < ApplicationController
  before_action :authorize_request
  
  def index
    if params[:hospital_registration_id].present?
      hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
      
      if hospital
        if params[:patient_phone_number].present?
          @patients = hospital.patients.where(phone_number: params[:patient_phone_number])
        else
          @patients = hospital.patients.all
        end
        
        render json: @patients, status: :ok
      else
        render json: { error: 'Hospital not found' }, status: :not_found
      end
    else
      render json: { error: 'Hospital registration ID is required' }, status: :bad_request
    end
  end
end
