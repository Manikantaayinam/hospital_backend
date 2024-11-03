class DoctorsController < ApplicationController
  before_action :authorize_request
  before_action :set_doctor, only: [:show, :update, :destroy, :restore]

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    if hospital.present?
      page = (params[:page].presence || 1).to_i
      per_page = (params[:per_page].presence || 10).to_i

      doctors_query = hospital.doctors.all
      doctors_query = apply_search(doctors_query)


      total_records = doctors_query.count
      total_pages = (total_records / per_page.to_f).ceil

      paginated_doctors = doctors_query.order(created_at: :desc).offset((page - 1) * per_page).limit(per_page)

      render json: {
        doctors: ActiveModelSerializers::SerializableResource.new(paginated_doctors, each_serializer: DoctorSerializer),
        meta: pagination_meta(total_records, page, per_page)
      }, status: :ok
    else
      render json: { error: 'Hospital not found' }, status: :not_found
    end
  end

  def create
    @doctor = @current_user.doctors.build(doctor_params)
    @doctor.assign_attributes(status: "active", role: "Doctor")

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

   def apply_search(doctors_query)
    return doctors_query unless params[:search].present?

    search_term = "%#{params[:search]}%"
    doctors_query.where(
      'name ILIKE ? OR email ILIKE ? OR specialist_in::text ILIKE ? OR phone_number::text ILIKE ?',
      search_term, search_term, search_term, search_term
    )
  end
  def pagination_meta(total_records, current_page, per_page)
    {
      current_page: current_page,
      per_page: per_page,
      total_pages: (total_records / per_page.to_f).ceil,
      total_records: total_records
    }
  end
end
