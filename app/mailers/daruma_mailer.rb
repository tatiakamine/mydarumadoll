#encoding: utf-8

class DarumaMailer < ActionMailer::Base
  default from: "daruma@mydarumadoll.com"
  
  def create_daruma_email(sender, user)
    @user = user
    @sender = sender
    mail(:to => user.email, :subject => "Você ganhou um Daruma!")
      
    #TODO arrumar texto do email e criar versão TXT
  end
  
  def create_confirmation_email(sender, user, token)
    @user = user
    @sender = sender
    @token = token
    mail(:to => sender.email, :subject => "Você enviou um Daruma?")
    #TODO texto com token
  end
  
end
