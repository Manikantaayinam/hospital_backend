class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      
      case @decoded[:role]
      when 'Doctor'
        @current_user = Doctor.find(@decoded[:id])
      when 'HospitalRegistration'
        @current_user = HospitalRegistration.find(@decoded[:id])
      when 'Receptionist'
        @current_user = Receptionist.find(@decoded[:id])
      else
        render json: { error: 'Invalid user role' }, status: :unauthorized
        return
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
