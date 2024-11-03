class DoctorAppointmentsController < ApplicationController
  before_action :authorize_request

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])

    if hospital.present? && @current_user.role == "Doctor"
      page = (params[:page].presence || 1).to_i
      per_page = (params[:per_page].presence || 10).to_i

      appointments = @current_user.appointments.includes(:patient)

      if params[:filter] == 'today'
        appointments = appointments.where("DATE(created_at) = ?", Date.today)
      end

      appointments = apply_search(appointments)

      total_records = appointments.count
      total_pages = (total_records / per_page.to_f).ceil

      paginated_appointments = appointments.order(created_at: :desc).offset((page - 1) * per_page).limit(per_page)

      render json: {
        appointments: ActiveModelSerializers::SerializableResource.new(paginated_appointments, each_serializer: AppointmentSerializer),
        meta: {
          current_page: page,
          per_page: per_page,
          total_pages: total_pages,
          total_records: total_records
        }
      }, status: :ok
    else
      render json: { error: hospital ? 'Unauthorized access' : 'Hospital not found' }, status: hospital ? :forbidden : :not_found
    end
  end
  
  private 

  def apply_search(appointments)
    return appointments unless params[:search].present?
    search_term = params[:search]
    doctor_id_condition = doctor_id_condition_for(search_term)

    appointments.where('problem ILIKE ? OR appointment_status ILIKE ? OR appointment_type ILIKE ? OR doctor_id = ?',
                       "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", doctor_id_condition)
  end

  def doctor_id_condition_for(search_term)
    Integer(search_term) rescue nil
  end

  def render_error(record)
    render json: { error: record.errors.full_messages }, status: :unprocessable_entity
  end
end
