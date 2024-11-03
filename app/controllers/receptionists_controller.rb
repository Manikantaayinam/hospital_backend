class ReceptionistsController < ApplicationController
  before_action :authorize_request
  before_action :set_receptionist, only: [:show, :update, :destroy, :restore]

  def index
    page = (params[:page].presence || 1).to_i
    per_page = (params[:per_page].presence || 10).to_i

    receptionists_scope = @current_user.receptionists.with_deleted

    receptionists_scope = apply_search_filters(receptionists_scope)

    total_records = receptionists_scope.count
    paginated_receptionists = paginate(receptionists_scope, page, per_page)

    render json: {
      receptionists: ActiveModelSerializers::SerializableResource.new(paginated_receptionists, each_serializer: ReceptionistSerializer),
      meta: pagination_meta(page, per_page, total_records)
    }, status: :ok
  end

  def create
    @receptionist = @current_user.receptionists.build(receptionist_params)
    @receptionist.status = "active"
    @receptionist.role = "Receptionist"
    if @receptionist.save
      render json: { message: "Receptionist created successfully", account: @receptionist }, status: :created
    else
      render json: { errors: "Failed to create receptionist", errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @receptionist, status: :ok
  end

  def update
    if @receptionist.update(receptionist_params)
      render json: { message: "Receptionist updated successfully", account: @receptionist }, status: :ok
    else
      render json: { errors: "Failed to update receptionist", errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @receptionist.update(status: "inactive")
    render json: { message: "Receptionist deactivated successfully" }, status: :ok
  end

  def restore
    @receptionist.update(status: "active")
    @receptionist.restore
    render json: { receptionist: @receptionist, message: 'Receptionist was successfully restored.' }, status: :ok
  end

  private

  def receptionist_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :profile)
  end

  def set_receptionist
    @receptionist = @current_user.receptionists.with_deleted.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Receptionist not found" }, status: :not_found
  end

  def paginate(scope, page, per_page)
    scope.offset((page - 1) * per_page).limit(per_page)
  end

  def pagination_meta(current_page, per_page, total_records)
    total_pages = (total_records / per_page.to_f).ceil
    {
      current_page: current_page,
      per_page: per_page,
      total_pages: total_pages,
      total_records: total_records
    }
  end

  def apply_search_filters(scope)
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      scope = scope.where(
        "name ILIKE ? OR email ILIKE ? OR address ILIKE ? OR phone_number::text ILIKE ?",
        search_term, search_term, search_term, search_term
      )
    end
    scope
  end
end
