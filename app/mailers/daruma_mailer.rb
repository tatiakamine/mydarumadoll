class DarumaMailer < ActionMailer::Base
  default from: "daruma@mydarumadoll.com"
  
  def create_daruma_email(sender, user)
      @user = user
      @sender = sender
      mail(:to => user.email, :subject => "Voce ganhou um Daruma!")
      
      #TODO arrumar texto do email e criar versão TXT
    end
end
