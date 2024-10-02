class NursesController < ApplicationController
  before_action :set_nurse, only: [:show, :edit, :update, :destroy, :restore]
  before_action :authorize_request

  def index
     hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    @nurses = hospital.nurses.with_deleted.all
    render json: @nurses, status: :ok
  end

  def show
  end

  def new
    @nurse = Nurse.new
  end

def create
  hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])

  if hospital
    @nurse = hospital.nurses.create(nurse_params)
  else
    @nurse = @current_user.nurses.create(nurse_params)
  end

  @nurse.role = "Nurse"
  @nurse.status = "active"

  if @nurse.save
    render json: { nurse: @nurse, message: 'Nurse was successfully created.' }, status: :created
  else
    render json: { errors: @nurse.errors.full_messages }, status: :unprocessable_entity
  end
end

  def edit
  end

   def update
    if @nurse.update(nurse_params)
      render json: { nurse: @nurse, message: 'Nurse was successfully updated.' }, status: :ok
    else
      render json: { errors: @nurse.errors.full_messages }, status: :unprocessable_entity
    end
  end

 def destroy
      @nurse.update(status: "inactive")

    @nurse.destroy
    render json: { message: 'Nurse was successfully deleted.' }, status: :ok
  end

  def restore
    @nurse.update(status: "active")
    @nurse.restore
    render json: { nurse: @nurse, message: 'Nurse was successfully restored.' }, status: :ok
  end

  private

  def set_nurse
    @nurse = Nurse.with_deleted.find(params[:id])
  end

  def nurse_params
    params.permit(:name, :address, :phone_number, :email, :profile)
  end
end
