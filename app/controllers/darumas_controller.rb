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
    @daruma.token = TokenSingleton.instance.generateToken
    
    respond_to do |format|
      if (@daruma.captcha == '4') and (@daruma.save)
        DarumaMailer.create_confirmation_email(@daruma.sender, @daruma.user, @daruma.id, @daruma.token).deliver
        format.html { render action: "sent" } #TODO ir pra uma página de verdade
        
      else
        if (@daruma.captcha != '4')
          @daruma.errors.add(:captcha, "Essa conta está errada! Dica: a resposta é 4 :)")
        end        
        format.html { render action: "new" }        
      end
    end
  end

  # GET /darumas/confirm
  def confirm
    @id = params[:id]
    @token = params[:token]

    @daruma = Daruma.find(@id)

    respond_to do |format|
      if @token == @daruma.token
        if @daruma.status == Daruma::STATUS_CREATED
          @daruma.status = Daruma::STATUS_CONFIRMED
          @daruma.save
        end
        format.html { render action: "confirmed" }

      else
        @daruma.errors.add(:token, "Invalid token")
        format.html { render action: "confirmed" }
      end
    end

  end

end
