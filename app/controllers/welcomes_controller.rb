class WelcomesController < ApplicationController
	def index 
		render json: {messages: "Hello Buddy Welcome...!"}
	end
end
