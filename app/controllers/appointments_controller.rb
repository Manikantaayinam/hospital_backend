class AppointmentsController < ApplicationController
  before_action :authorize_request 

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    if hospital.present?
      @appointments = hospital.appointments.includes(:patient).all
      render json: @appointments, each_serializer: AppointmentSerializer, status: :ok
    else
      render json: { error: 'Hospital not found' }, status: :not_found
    end
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      @appointment = Appointment.new(appointment_params)
      @appointment.patient_id = @patient.id
      @appointment.appointment_status = "Accepted"

      if @appointment.save
        if @appointment.appointment_type == "IP"
          process_bed_assignment
        else
          render_success_response
        end
      else
        render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.permit(:name, :gender, :occupation, :age, :address, :phone_number, :hospital_registration_id)
  end

  def appointment_params
    params.permit(:problem, :doctor_id, :appointment_timing, :consultancy_fees, :appointment_type, :hospital_registration_id)
  end

  def process_bed_assignment
    bed = Bed.find_by(id: params[:bed_id])

    if bed.present?
      if bed.status != "occupied"
        bed.update(status: "occupied", entryDate: Date.today)
        @appointment.update(bed_id: bed.id)
        render_success_response
      else
        render json: { errors: "This bed is occupied" }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Bed not found" }, status: :not_found
    end
  end

  def render_success_response
    render json: { messages: "Appointment Created", appointment: AppointmentSerializer.new(@appointment) }, status: :created
  end
end
