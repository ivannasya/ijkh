class WebMoney

  def self.invoice_confirmation(merchant_id, payment_amount, order_id)
    true_merchant_id = "6c2aa990-60e1-427f-9c45-75cffae4a745"
    recipe = Recipe.find(order_id)
    if recipe.total == payment_amount.to_i && merchant_id == true_merchant_id
      text = "YES"
    else
      text = "NO"
    end
    text
  end

  def self.payment_notification(order_id, sys_payment_id, sys_payment_date, payment_amount, currency)
    @sys_payment_id = sys_payment_id
    @sys_payment_date = sys_payment_date
    @payment_amount = payment_amount
    @currency = currency
    @order_id = order_id

    payment_history_create_successful
  end

  def self.failed_payment(order_id, payment_amount, currency)
    @payment_amount = payment_amount
    @currency = currency
    @order_id = order_id

    payment_history_create_failed
  end

  private

  def self.payment_params
    recipe = Recipe.find(@order_id)
    if recipe
      service_id = recipe.service_id
    else
      service_id = 0
    end

    payment_history_params = {
      po_date_time:       @sys_payment_date,
      po_transaction_id:    @sys_payment_id,
      recipe_id:        recipe.id,
      amount:         @payment_amount,
      currency:         @currency,
      user_id:        recipe.user_id,
      payment_type:       "3",
      service_id:       service_id,
    }

    return payment_history_params
  end

  def self.payment_history_create_successful
    payment_history_params = payment_params
    payment_history_params.merge!(status: 1)
    payment_history = PaymentHistory.new(payment_history_params)
    payment_history.save

    service_id = payment_history_params[:service_id]
    if service_id != 0
      service = Service.find(service_id)
      if service && service.vendor_id.to_i == 121
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        GtPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount)
      #elsif service && service.vendor_id.to_i == 16
        #JtPaymentWorker.perform_async(params[:user_id])
      elsif service && service.vendor_id.to_i == 135
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        SlPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount) 
      elsif service && service.vendor_id.to_i == 165
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        CraftSPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount)
      elsif service && service.vendor_id.to_i == 144

        recipe_id = payment_history_params[:recipe_id]

        # amount = Recipe.find(recipe_id).amount

        user_id = service.user.id
        freelancer = FreelanceInterface::Freelancer.where(recipe_id: recipe_id).first
        top_ten = FreelanceInterface::TopTenFreelancer.where(recipe_id: recipe_id).first
        top_four = FreelanceInterface::TopFourFreelancer.where(recipe_id: recipe_id).first

        if freelancer
          unpublish_at = Date.current() + freelancer.number_of_month.to_i.month
          freelancer.update_attributes!(unpublish_at: unpublish_at)
          if top_ten
            unpublish_at = Date.current() + top_ten.number_of_month.to_i.month
            top_ten.update_attributes!(unpublish_at: unpublish_at)
          end
        else 
          if top_ten
            unpublish_at = Date.current() + top_ten.number_of_month.to_i.month
            top_ten.update_attributes!(unpublish_at: unpublish_at)
          else
            if top_four
              unpublish_at = Date.current() + top_four.number_of_month.to_i.month
              top_four.update_attributes!(unpublish_at: unpublish_at)             
            end
          end
        end
      end
    end

    service_id = Recipe.get_service_id payment_history_params[:recipe_id]

    recipe = Recipe.find(payment_history_params[:recipe_id])

    account = Account.update_account_amount service_id, recipe.amount, recipe.amount # recipe.amount only once!!!

    if account[:amount] <= 0
      
      switch_status_params = {
        account_id: account[:account_id],
        status: 1,
        user_id: recipe.user_id
      }

      Account.switch_status switch_status_params

      user = User.find(recipe.user_id)
    #   NotificationsSuccessfulPaymentWorker.perform_async(recipe.total, service.title, service.user_account, user.first_name, user.email)
    else
      switch_status_params = {
        account_id: account[:account_id],
        status: -1
      }

      Account.switch_status switch_status_params
    end
  end

  def self.payment_history_create_failed
    payment_history_params = payment_params
    payment_history_params.merge!(status: -1)
    payment_history = PaymentHistory.new(payment_history_params)
    payment_history.save
    
    recipe = Recipe.find(payment_history_params[:recipe_id])
    account_id = recipe.account.id

    switch_status_params = {
      account_id: account_id,
      status: -1
      }

      Account.switch_status switch_status_params

    return payment_history
  end
end