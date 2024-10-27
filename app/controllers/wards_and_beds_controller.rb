class WardsAndBedsController < ApplicationController
  # before_action :authorize_request

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    if hospital
      @wards = hospital.wards.includes(:beds) # Use includes to optimize queries
      render json: @wards, each_serializer: WardsAndBedsSerializer, status: :ok
    else
      render json: { error: 'Hospital not found' }, status: :not_found
    end
  end

  def create
  new_ward_creation = ActiveModel::Type::Boolean.new.cast(params[:new_ward_creation])

    if params[:ward_id].present? && !new_ward_creation
      ward = Ward.find_by(id: params[:ward_id])
      if ward
        bed = ward.beds.build(bed_params)
        bed.status = "Available"
        if bed.save
          render json: bed, status: :created
        else
          render json: { errors: bed.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Ward not found' }, status: :not_found
      end
    elsif params[:ward_name].present? && new_ward_creation
      hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
      if hospital
        ward = hospital.wards.build(ward_params)
        if ward.save
          bed = ward.beds.build(bed_params)
          bed.status = "Available"
          if bed.save
            ward.update(available_beds: ward.beds.count)
            render json: { ward: ward, bed: bed }, status: :created
          else
            render json: { errors: bed.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ward.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Hospital not found' }, status: :not_found
      end
    else
      render json: { error: 'Invalid parameters' }, status: :bad_request
    end
  end

  private

  def bed_params
    params.permit(:bed_number, :bed_type, :cost_per_day)
  end

  def ward_params
    params.permit(:ward_number, :ward_name)
  end
end
