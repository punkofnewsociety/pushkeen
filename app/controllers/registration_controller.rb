require 'net//http'
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
  
  @question = params[:question]
  @id = params[:id]
  @level = params[:level]
  render nothing:true
  puts @question
  @answer = Title.find_by_id(Str.find_by("text LIKE ?", "%#{@question}%").titleid).name
  puts @answer
  uri = URI("http://pushkin-contest.ror.by/quiz")
  parameters = {
    answer: @answer,
    token: 'dc574bf8a22d1adceb04e8f6c4fefc5d',
    task_id:  @id
  }
  
  Net::HTTP.post_form(uri, parameters)
  
  end
  
end     
