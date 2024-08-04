class ReceptionistsController < ApplicationController
    before_action :authorize_request
    before_action :set_receptionist, only: [:show, :update, :destroy]
  
    def index
      @receptionists = Receptionist.all
      render json: @receptionists
    end
  
    def show
      render json: @receptionist
    end
  
    def create
      @receptionist = Receptionist.new(receptionist_params)
      if @receptionist.save
        render json: { message: "Receptionist created successfully", receptionist: @receptionist }, status: :created
      else
        render json: { errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @receptionist.update(receptionist_params)
        render json: { message: "Receptionist updated successfully", receptionist: @receptionist }
      else
        render json: { errors: @receptionist.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @receptionist.destroy
      render json: { message: "Receptionist deleted successfully" }, status: :no_content
    end
  
    private
  
    def set_receptionist
      @receptionist = Receptionist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Receptionist not found" }, status: :not_found
    end
  
    def receptionist_params
      params.permit(:name, :address, :phone_number, :role, :email, :password, :password_confirmation)
    end
  end
  