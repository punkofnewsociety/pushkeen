require 'uri'
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
  #render nothing:true
  
  case @level
  when '1'
    self.first
  when '2'
    self.second
  when '3'
    self.third
  when '4'
    self.fourth
  end
  puts @question
  puts @answer
  uri = URI("http://pushkin.rubyroid.by/quiz")

  poparameters = {
    answer: @answer,
    token: 'dc574bf8a22d1adceb04e8f6c4fefc5d',
    task_id:  @id
  }
  render json: {answer: @answer} 
  #Net::HTTP.post_form(uri, poparameters)
  end
  
  def first
    @answer = Title.find_by_id(Str.find_by("text LIKE ?", "%#{@question}%").titleid).name
  end
  
  def second
    if @question.index("%") == 0 then
    st = @question.split('%WORD%')
    puts st[1]
    
    p = Str.find_by("text LIKE ?", "%#{st[1]}%").text.gsub(/(.*?)#{st[1]}/){@answer = $1.strip}
    i=0
    a=String.new
      while      !!@answer.reverse![i].downcase! do
       a = a + @answer[i]
       i+=1
      end
    @answer=a
    else
    st = @question.split(' %WORD% ')
    #p = Str.find_by("text LIKE ?", "%#{st[0]}%" "%#{st[1]}%").text.gsub(/#{st[0]}(.*?)#{st[1]}/){@answer = $1.strip}
    p = Str.find_by("text LIKE ?", "%#{st[0]}%" "%#{st[1]}%").text
    p st[0]
    p st[1]
     leftstr=p.partition(st[0]+' ')
     xxx=leftstr.delete("")
     p leftstr
    puts "123"
     rightstr=p.partition(' '+st[1])
     p rightstr
    top=rightstr[0].delete(leftstr[0])
    p top
    @answer=top.to_s
    
    end
  end
  
  def third
    ch = @question.split('\n')
    puts ch[0]
    puts "HUI"
    puts ch[1]
    @question=ch[0]
    self.second
    firstword=@answer
    @question=ch[1]
    puts @answer
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
