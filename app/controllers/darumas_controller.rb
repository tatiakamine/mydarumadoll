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
    id = params[:id]
    token = params[:token]

    @daruma = Daruma.find_by_id(id)

    respond_to do |format|
      if (not @daruma.blank?) and (token == @daruma.token)
        if @daruma.status == Daruma::STATUS_CREATED
          @daruma.status = Daruma::STATUS_SENT #TODO está fazendo isso? colocar em algum teste
          @daruma.save
          DarumaMailer.create_daruma_email(@daruma.sender, @daruma.user).deliver
        end
        format.html { render action: "confirmed" }

      else
        @error = "Alguma coisa deu errado ao confirmar o seu e-mail." #TODO colocar email pra contato do suporte
        format.html { render action: "error" }
      end
    end
  end

  # GET /darumas/makeawish
  def makeawish
    id = params[:id]
    token = params[:token]

    @daruma = Daruma.find_by_id(id)

    respond_to do |format|
      if @daruma and token == @daruma.token and @daruma.status == Daruma::STATUS_SENT #TODO testar também status
        format.html # makeawish.html.erb
      else
        @error = "Alguma coisa deu errado ao buscar o seu daruma." #TODO colocar email pra contato do suporte
        format.html { render action: "error" }
      end
    end
  end

end
