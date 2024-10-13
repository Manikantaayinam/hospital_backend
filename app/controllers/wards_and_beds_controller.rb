class WardsAndBedsController < ApplicationController
  before_action :authorize_request

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @wards = hospital.wards.includes(:beds) # Use includes to optimize queries
    render json: @wards, each_serializer: WardsAndBedsSerializer, status: :ok
  end
end
