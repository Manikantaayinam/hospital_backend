class AppointmentsController < ApplicationController
  before_action :authorize_request 

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @appointments = hospital.appointments.includes(:patient).all

    render json: @appointments, each_serializer: AppointmentSerializer, status: :ok
  end

  def create
    @patient = Patient.new(patient_params)

      if @patient.save
        @appointment = Appointment.new(appointment_params)
        @appointment.patient_id = @patient.id
        @appointment.appointment_status = "Accepted"

        if @appointment.save
          if @appointment.appointment_type == "IP"  
            @bed = Bed.find(params[:bed_id])

            if @bed.status != "occupied"
              @bed.update(status: "occupied", entryDate: Date.today)
            else
              # Render error if the bed is occupied and exit the action
              return render json: { errors: "This bed is occupied" }, status: :unprocessable_entity
            end
          end

          # Render success message only if no errors occurred
          render json: { messages: "Appointment Created", appointment: AppointmentSerializer.new(@appointment) }, status: :created  
        else
          render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: @patient.errors.full_messages }, status: :unprocessable_entity
      end
  end

  private

  def patient_params
    params.permit(:name, :dob, :gender, :bloodgroup, :address, :phone_number, :hospital_registration_id)
  end

  def appointment_params
    params.permit(:problem, :doctor_id, :appointment_timing, :consultancy_fees, :appointment_type, :hospital_registration_id)
  end
end



# problem,doctor_id,appointment_timing, consultancy_fees,appointment_type,bed_id, name,date_of_birth, gender, bloodgroup,address,phone_number,hospital_registration_id