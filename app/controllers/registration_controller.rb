class RegistrationController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  $taken = 0
  def index    
    aaa = params[:question]
    abc = params[:token]
    puts "#$taken"
  end
  
  def new
  @token = params[:token]
  @question = params[:question]
  $taken=@token
  puts @question
  st = @question.split(' %WORD% ')
  p = Str.find_by("text LIKE ?", "%#{st[0]}%" "%#{st[1]}%").text.gsub(/#{st[0]}(.*?)#{st[1]}/){@answer = $1.strip}
  render json: {answer: @answer} 
  end
  
  def play
  
  
  
  end
  
end     
