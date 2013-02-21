#encoding: utf-8
class DarumasController < ApplicationController
  # GET /darumas/new
  def new
    @daruma = Daruma.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # POST /darumas
  def create
    @daruma = Daruma.new(params[:daruma])
    @daruma.left_eye = false;
    @daruma.right_eye = false;
    @daruma.status = Daruma::STATUS_CREATED
    
    respond_to do |format|
      if (@daruma.captcha == '4') and (@daruma.save)
        DarumaMailer.create_daruma_email(@daruma.sender, @daruma.user).deliver
        format.html { render action: "sent" } #TODO ir pra uma página de verdade
        
      else
        if (@daruma.captcha != '4')
          @daruma.errors.add(:captcha, "Essa conta está errada! Dica: a resposta é 4 :)")
        end        
        format.html { render action: "new" }        
      end
    end
  end

end
