class WardsAndBedsController < ApplicationController
  before_action :set_hospital, only: [:index, :create]
  before_action :authorize_request
  def index
    @wards = @hospital.wards.includes(:beds) 
    render json: @wards, each_serializer: WardsAndBedsSerializer, status: :ok
  end

  def create
    if params[:new_ward_creation] == 'true' && params[:ward_name].present?
      create_new_ward_with_bed
    elsif params[:ward_id].present?
      add_bed_to_existing_ward
    else
      render json: { error: 'Invalid parameters' }, status: :bad_request
    end
  end

  private

  def set_hospital
    @hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    render json: { error: 'Hospital not found' }, status: :not_found unless @hospital
  end

  def create_new_ward_with_bed
    ward = @hospital.wards.build(ward_params)

    if ward.save
      bed = ward.beds.build(bed_params.merge(status: "Available"))
      if bed.save
        ward.update(available_beds: ward.beds.count)
        render json: { ward: ward, bed: bed }, status: :created
      else
        render_errors(bed)
      end
    else
      render_errors(ward)
    end
  end

  def add_bed_to_existing_ward
    ward = Ward.find_by(id: params[:ward_id])
    return render json: { error: 'Ward not found' }, status: :not_found unless ward

    bed = ward.beds.build(bed_params.merge(status: "Available"))
    if bed.save
      render json: bed, status: :created
    else
      render_errors(bed)
    end
  end

  def render_errors(resource)
    render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
  end

  def bed_params
    params.permit(:bed_number, :bed_type, :cost_per_day)
  end

  def ward_params
    params.permit(:ward_number, :ward_name)
  end
end
