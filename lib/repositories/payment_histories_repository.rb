module PaymentHistoriesRepository
	def create_payment_history params
		if params[:action] == "fail"
			payment_history = create_failed params
		else
			payment_history = create_successful params
		end
		return payment_history
	end

	def get_by_service_id user, service_id
		payment_histories = PaymentHistory.where("user_id = ? and service_id = ? and status = 1", user.id, service_id).select("id, amount, updated_at")
		return payment_histories
	end

	private

	def pack_params params
		recipe = Recipe.find(params[:OrderId])
		if recipe
			service_id = recipe.service_id
		else
			service_id = 0
		end

		payment_history_params = {
			po_date_time: 			params[:DateTime], 
			po_transaction_id: 		params[:TransactionID], 
			recipe_id: 				params[:OrderId].to_i,
			amount: 				params[:Amount],
			currency: 				params[:Currency],
			card_holder: 			params[:CardHolder],
			card_number: 			params[:CardNumber],
			country: 				params[:Country],
			city: 					params[:City],
			eci: 					params[:ECI],
			user_id: 				params[:user_id].to_i,
			payment_type: 			"1",
			service_id: 			service_id
		}

		return payment_history_params
	end

	def create_successful params
		payment_history_params = pack_params params
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
		
		if params[:RebillAnchor]
			# user_id is passed in params hash because 
			# current_user object is not availible 
			# for PayOnline callback operation
			card_params = {
				rebill_anchor: 		params[:RebillAnchor],
				card_title: 		params[:CardNumber],
				user_id: 			params[:user_id]
			}
			card = Card.create_card card_params
		end

		service_id = Recipe.get_service_id payment_history_params[:recipe_id]

		recipe = Recipe.find(payment_history_params[:recipe_id])

		account = Account.update_account_amount service_id, recipe.amount, recipe.amount # recipe.amount only once!!!

		if account[:amount] <= 0
			
			switch_status_params = {
				account_id: account[:account_id],
				status: 1,
				user_id: params[:user_id]
			}

			Account.switch_status switch_status_params

			user = User.find(params[:user_id].to_i)
			NotificationsSuccessfulPaymentWorker.perform_async(recipe.total, service.title, service.user_account, user.first_name, user.email)
		else
			switch_status_params = {
				account_id: account[:account_id],
				status: -1
			}

			Account.switch_status switch_status_params
		end

		return payment_history
	end

	def create_failed params
		payment_history_params = pack_params params
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