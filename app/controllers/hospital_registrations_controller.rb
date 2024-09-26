class HospitalRegistrationsController < ApplicationController
        before_action :authorize_request, except: [:create]
        before_action :find_hospital, except: [:create, :index]
        
        def index
          @hospitals = HospitalRegistration.all
          render json:  @hospitals, status: :ok
        end
      
        def show
          render json:  @hospital, status: :ok
        end
      
        def create
          @hospital = HospitalRegistration.new(hospital_params)
          if @hospital.save
            render json: @hospital, status: :created
          else
            render json: { errors: @hospital.errors.full_messages }, status: :unprocessable_entity
          end
        end
      
        def update
          if @hospital.update(hospital_params)
            render json: @hodpital, status: :ok
          else
            render json: { errors: @hospital.errors.full_messages }, status: :unprocessable_entity
          end
        end
      
        def destroy
          @hospital.destroy
          head :no_content
        end
      
        private
      
        def find_hospital
          @hospital = HospitalRegistration.find(params[:id])
        end
        

      
        def hospital_params
          params.require(:hospital).permit(:hos_name, :email, :password, :password_confirmation, :location)
        end
   
      
  end
  
