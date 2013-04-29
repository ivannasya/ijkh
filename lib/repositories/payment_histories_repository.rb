class PaymentHistoriesRepository
	def create_payment_history user, params
		if params[:action] == "fail"
			payment_history = create_failed user, params
		else
			payment_history = create_succesful user, params
		end
		return payment_history
	end
	
	private

	def pack_params user, params
		payment_history_params = {
			po_date_time: 			params[:DateTime], 
			po_transaction_id: 		params[:TransactionID], 
			recipe_id: 				params[:OrderId], 
			amount: 				params[:Amount], 
			currency: 				params[:Currency], 
			card_holder: 			params[:CardHolder], 
			card_number: 			params[:CardNumber], 
			country: 				params[:Country], 
			city: 					params[:City], 
			eci: 					params[:ECI],
			user_id: 				user.id,
			type: 					1
		}

		return payment_history_params
	end

	def create_successful user, params
		payment_history_params = pack_params user, params
		payment_history_params.merge status: 1
		payment_history = PaymentHistory.new(payment_history_params)

		if params[:RebillAnchor]
			card_params = {
				rebill_anchor: 		params[:RebillAnchor],
				card_title: 		params[:CardNumber]
			}
			card = Card.create_card current_user, card_params
		end

		service_id = Recipe.get_service_id payment_history_params[:recipe_id]

		account = Account.update_account_amount service_id, payment_history_params[:amount]

		if account[:amount] <= 0
			
			switch_status_params = {
				account_id: account[:account_id],
				status: 1
			}

			Account.switch_status switch_status_params
		else
			switch_status_params = {
				account_id: account[:account_id],
				status: -1
			}

			Account.switch_status switch_status_params
		end

		return payment_history
	end

	def create_failed user, params
		payment_history_params = pack_params user, params
		payment_history_params.merge status: -1
		payment_history = PaymentHistory.new(payment_history_params)

		return payment_history
	end
end