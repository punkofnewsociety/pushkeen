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
  puts st[0]
  puts st[1]
  p = Str.find_by('text LIKE ?', "%#{st[0]}% %#{st[1]}%")
  p.text.gsub(/#{st[0]}(.*?)#{st[1]}/){@answer = $1.strip}
  render json: {answer: @answer} 
  end
end
