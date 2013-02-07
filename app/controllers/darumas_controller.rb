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

    respond_to do |format|
      if @daruma.save
        DarumaMailer.create_daruma_email(@daruma.sender, @daruma.user).deliver
#        format.html { redirect_to @daruma, notice: 'User was successfully created.' }
        format.html { render action: "sent" } #TODO ir pra uma página de verdade
      else
        logger.debug @daruma.errors #TODO nao tá logando, parece
        format.html { render action: "new" }
      end
    end
  end

  
end
