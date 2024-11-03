class AppointmentsController < ApplicationController
  before_action :authorize_request 
  before_action :set_hospital, only: [:index, :create]
  
def index
  hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])

  if hospital.present?
    page = (params[:page].presence || 1).to_i
    per_page = (params[:per_page].presence || 10).to_i

    appointments = hospital.appointments.includes(:patient)
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
    render json: { error: 'Hospital not found' }, status: :not_found
  end
end


  def create
    ActiveRecord::Base.transaction do
      @patient = Patient.create!(patient_params)
      @appointment = Appointment.new(appointment_params.merge(patient_id: @patient.id, appointment_status: "Accepted"))

      if @appointment.save
        @appointment.appointment_type == "IP" ? process_bed_assignment : process_payment_and_render_response
      else
        render_error(@appointment)
      end
    rescue ActiveRecord::RecordInvalid => e
      render_error(e.record)
    end
  end

  private

  def set_hospital
    @hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    render json: { error: 'Hospital not found' }, status: :not_found unless @hospital
  end

  def patient_params
    params.permit(:name, :gender, :occupation, :age, :address, :phone_number, :hospital_registration_id)
  end

  def appointment_params
    params.permit(:problem, :doctor_id, :appointment_timing, :consultancy_fees, :appointment_type, :hospital_registration_id)
  end

  def process_bed_assignment
    bed = Bed.find_by(id: params[:bed_id])
    if bed&.status != "occupied"
      bed.update!(status: "occupied", entryDate: Date.today)
      @appointment.update!(bed_id: bed.id)
      process_payment_and_render_response
    else
      render json: { error: bed ? "This bed is occupied" : "Bed not found" }, status: bed ? :unprocessable_entity : :not_found
    end
  end

  def process_payment_and_render_response
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @payment = Payment.create!(patient_id: @patient.id, appointment_id: @appointment.id, total_amount: @appointment.consultancy_fees,
      paid_amount: 0, payment_mode: "not yet started", hospital_registration_id: hospital.id)
    update_payment_status(@payment)
    render json: { message: "Appointment Created", appointment: AppointmentSerializer.new(@appointment) }, status: :created
  end

  def update_payment_status(payment)
    payment_status = payment.total_amount > payment.paid_amount ? "Payment Due" : "Completed"
    payment.update!(payment_status: payment_status, due_amount: [0, payment.total_amount - payment.paid_amount].max)
  end

  def apply_search(appointments)
  return appointments unless params[:search].present?
    search_term = params[:search]
    doctor_id_condition = doctor_id_condition_for(search_term)
    appointments.where('problem ILIKE ? OR appointment_status = ? OR appointment_type = ? OR doctor_id = ?', 
                       "%#{search_term}%", search_term, search_term, doctor_id_condition)
  end


  def doctor_id_condition_for(search_term)
    Integer(search_term) rescue nil
  end


  def render_error(record)
    render json: { error: record.errors.full_messages }, status: :unprocessable_entity
  end
end
