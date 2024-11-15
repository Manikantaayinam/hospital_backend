class PatientsController < ApplicationController
  # before_action :authorize_request
  before_action :set_hospital, only: [:index]

  def index
    patients_scope = @hospital.patients
    patients_scope = apply_filters(patients_scope)

    paginated_patients = paginate_patients(patients_scope)

    render json: {
      patients: ActiveModelSerializers::SerializableResource.new(paginated_patients, each_serializer: PatientSerializer),
      meta: pagination_meta(patients_scope)
    }, status: :ok
  end

  private

  def set_hospital
    @hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    render json: { error: 'Hospital not found' }, status: :not_found unless @hospital
  end

  def apply_filters(scope)
    scope = filter_by_phone_number(scope)
    scope = search_patients(scope)
    scope
  end

  def filter_by_phone_number(scope)
    return scope unless params[:patient_phone_number].present?

    scope.where(phone_number: params[:patient_phone_number])
  end

  def search_patients(scope)
    return scope unless params[:search].present?

    search_term = "%#{params[:search].downcase}%"
    scope.where(
      'LOWER(name) LIKE :term OR LOWER(gender) LIKE :term OR LOWER(occupation) LIKE :term OR LOWER(email) LIKE :term OR LOWER(address) LIKE :term OR LOWER(phone_number::text) LIKE :term OR LOWER(role) LIKE :term',
      term: search_term
    )
  end

  def paginate_patients(scope)
    page = (params[:page].presence || 1).to_i
    per_page = (params[:per_page].presence || 10).to_i
    scope.offset((page - 1) * per_page).limit(per_page)
  end

  def pagination_meta(scope)
    total_records = scope.count
    per_page = (params[:per_page].presence || 10).to_i
    {
      current_page: (params[:page].presence || 1).to_i,
      per_page: per_page,
      total_pages: (total_records / per_page.to_f).ceil,
      total_records: total_records
    }
  end
end
