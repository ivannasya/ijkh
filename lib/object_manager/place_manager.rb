class PlaceManager < ObjectManager

	def self.create(params, user)
		city_id = CityManager.get_by_title(params[:city])
		place = Place.create!(params.merge!(user_id: user.id, is_active: true, city_id: city_id))
		place
	end

	def self.deactivate(place)
		# Updates is_active attribute of given place to false, returns place

		if place.update_attributes(is_active: false)
			place
		else
			# Implement error class
		end
	end

	def self.index_by_user(user)
		# Finds and returns all places that belong to given user
		places = user.places.where(is_active: true)
	end

	def self.index_with_data_by_user(user)
		# Finds all places that belong to given user and returns 
		# it with all related data
	end

end