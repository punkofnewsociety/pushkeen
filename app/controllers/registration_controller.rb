class RegistrationController < ApplicationController
  def index
    p "123"
    p params[:question]
    p params[:token]
  end
end
