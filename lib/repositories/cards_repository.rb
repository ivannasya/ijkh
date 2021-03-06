module CardsRepository

	def create_card params
		card_params = {
			user_id: 		params[:user_id],
			card_title: 	params[:card_title],
			rebill_anchor: 	params[:rebill_anchor]
		}

		card = Card.where(rebill_anchor: params[:rebill_anchor])
		logger.info "1111" + card.inspect
		if card == []
			card = Card.new(card_params)
			card.save
		logger.info card.inspect
		end
	end

	def fetch_by_user user
		cards = Card.where(user_id: user.id)
		return cards
	end

	def delete_card card_id
		card = Card.find(card_id)
		if card.destroy
			return {status: "deleted"}
		end
	end

end