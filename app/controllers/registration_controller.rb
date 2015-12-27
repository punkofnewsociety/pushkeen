class RegistrationController < ApplicationController
  def index
    puts params[:question]
    puts params[:token]
  end
end
