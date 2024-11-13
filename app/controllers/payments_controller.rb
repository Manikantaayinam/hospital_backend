class PaymentsController < ApplicationController
  before_action :set_hospital, only: [:index]
  before_action :set_payment, only: [:show, :update, :destroy]
  before_action :authorize_request

  def index
    payments_scope = search_payments(@hospital.payments)

    paginated_payments = paginate_payments(payments_scope)

    render json: {
      payments: ActiveModelSerializers::SerializableResource.new(paginated_payments, each_serializer: PaymentSerializer),
      meta: pagination_meta(payments_scope)
    }, status: :ok
  end

  def show
    render json: @payment, serializer: PaymentSerializer, status: :ok
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      update_payment_status(@payment)
      render json: @payment, serializer: PaymentSerializer, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.update(payment_params)
      update_payment_status(@payment)
      render json: @payment, serializer: PaymentSerializer, status: :ok
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    render json: { message: 'Payment deleted successfully' }, status: :ok
  end

  private

  def set_hospital
    @hospital = HospitalRegistration.find_by(id: params[:hospital_registration_id])
    render json: { error: 'Hospital not found' }, status: :not_found unless @hospital
  end

  def set_payment
    @payment = Payment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Payment not found' }, status: :not_found
  end

  def payment_params
    params.permit(:patient_id, :appointment_id, :total_amount, :paid_amount, :payment_mode, :hospital_registration_id)
  end

    def search_payments(scope)
    return scope unless params[:search].present?

    search_term = "%#{params[:search].downcase}%"
    scope.where(
      'LOWER(payment_status) LIKE :term OR LOWER(payment_mode) LIKE :term',
      term: search_term
    )
  end

  def paginate_payments(scope)
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

  def update_payment_status(payment)
    payment_status, due_amount = if payment.total_amount > payment.paid_amount
                                    ["Payment Due", payment.total_amount - payment.paid_amount]
                                  elsif payment.total_amount == payment.paid_amount
                                    ["Completed", 0]
                                  else
                                    ["Overpaid", 0] 
                                  end
    payment.update(payment_status: payment_status, due_amount: due_amount)
  end
end
