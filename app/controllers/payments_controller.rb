class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :update, :destroy]
  # before_action :authorize_request

  def index
    page = (params[:page].presence || 1).to_i
    per_page = (params[:per_page].presence || 10).to_i

    paginated_payments = Payment.offset((page - 1) * per_page).limit(per_page)
    total_records = Payment.count
    total_pages = (total_records / per_page.to_f).ceil

    render json: {
      payments: ActiveModelSerializers::SerializableResource.new(paginated_payments, each_serializer: PaymentSerializer),
      meta: {
        current_page: page,
        per_page: per_page,
        total_pages: total_pages,
        total_records: total_records
      }
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
    if @payment.update(payment_params)
      update_payment_status(@payment)
      render json: @payment, serializer: PaymentSerializer, status: :ok
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy
    render json: { message: 'Payment deleted successfully' }, status: :ok
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Payment not found' }, status: :not_found
  end

  def payment_params
    params.permit(:patient_id, :appointment_id, :total_amount, :paid_amount, :payment_mode)
  end

  def update_payment_status(payment)
    if payment.total_amount > payment.paid_amount
      payment.update(payment_status: "Payment Due", due_amount: payment.total_amount - payment.paid_amount)
    elsif payment.total_amount == payment.paid_amount
      payment.update(payment_status: "Completed", due_amount: 0)
    end
  end
end
