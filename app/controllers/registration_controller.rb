class RegistrationController < ApplicationController
  def index ()
    p "123"
    a = @token
    p a
    b = params[:token]
    p b
    p params[:question]
    p params[:token]
    render json: {answer: 'мглою'}
  end
  
end
