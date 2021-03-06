# encoding: utf-8 

class WebInterface::FeedbackController < WebInterfaceController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(main_path, :notice => "Ваше сообщение успешно отправлено.")
    else
      flash.now.alert = "Пожалуйста, заполните все поля."
      render :new
    end
  end

end