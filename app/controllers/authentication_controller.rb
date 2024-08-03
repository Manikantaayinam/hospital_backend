class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    user = find_user(params[:email], params[:password])
    if user
      token = JsonWebToken.encode(id: user.id, role: user.role)
      render json: { token: token, exp: (Time.now + 24.hours).strftime("%m-%d-%Y %H:%M"), user_details: user }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
  private

  def find_user(email, password)
    user = Doctor.find_by(email: email) || HospitalRegistration.find_by(email: email) || Receptionist.find_by(email: email)
    user && user.authenticate(password) ? user : nil
  end
end
