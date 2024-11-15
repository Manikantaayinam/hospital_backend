class NursesController < ApplicationController
  before_action :set_nurse, only: [:show, :edit, :update, :destroy, :restore]
  before_action :authorize_request

  def index
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])

    if hospital
      page = (params[:page].presence || 1).to_i
      per_page = (params[:per_page].presence || 10).to_i

      nurses_query = hospital.nurses.all
      nurses_query = apply_search(nurses_query)

      total_records = nurses_query.count
      total_pages = (total_records / per_page.to_f).ceil
      paginated_nurses = nurses_query.limit(per_page)


      render json: {
        nurses: ActiveModelSerializers::SerializableResource.new(paginated_nurses, each_serializer: NurseSerializer),
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

  def show
  end

  def new
    @nurse = Nurse.new
  end

  def create
    hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])

    if hospital
      @nurse = hospital.nurses.build(nurse_params)
    else
      @nurse = @current_user.nurses.build(nurse_params)
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
    # Implementation for edit action (if needed)
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

  def apply_search(nurses_query)
    return nurses_query unless params[:search].present?

    search_term = "%#{params[:search]}%"
    
    nurses_query.where(
      'name ILIKE ? OR address ILIKE ? OR phone_number::text ILIKE ? OR email ILIKE ?',
      search_term, search_term, search_term, search_term
    )
  end
end
