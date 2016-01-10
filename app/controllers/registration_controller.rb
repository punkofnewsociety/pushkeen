require 'net/http'
class RegistrationController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  $taken = 0
  def index    
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
  
  case @level
  when 1
    self.first
  when 2
    self.second
  when 3
    self.third
  when 4
    self.fourth
  end
  puts @question
  puts @answer
  uri = URI("http://pushkin-contest.ror.by/quiz")
  
  poparameters = {
    answer => @answer,
    token => "dc574bf8a22d1adceb04e8f6c4fefc5d",
    task_id =>  @id
  }
  #render json: {answer: @answer} 
  Net::HTTP.post_form(uri, poparameters)
  end
  
  def first
    @answer = Title.find_by_id(Str.find_by("text LIKE ?", "%#{@question}%").titleid).name
  end
  
  def second
    st = @question.split(' %WORD% ')
    p = Str.find_by("text LIKE ?", "%#{st[0]}%" "%#{st[1]}%").text.gsub(/#{st[0]}(.*?)#{st[1]}/){@answer = $1.strip}
  end
  
  def third
    ch = @question.split('\n')
    @question=ch[0]
    self.second
    firstword=@answer
    @question=ch[1]
    self.second
    secondword=@answer
    @answer=firstword+', '+secondword

  end
  
  def fourth
    ch = @question.split('\n')
    @question=ch[0]
    self.second
    firstword=@answer
    @question=ch[1]
    self.second
    secondword=@answer
    @question=ch[2]
    self.second
    thirdword=@answer
    @answer=firstword+', '+secondword+', '+thirdword
  end
  
end     
