module BillsRepository

	def index_month_bill user, status
		month_bill = []
		months = 1..Date.today.month
		months.each do |month|
			sum_month = sum_up_month(user, month, status)
			month_bill << sum_month unless sum_month.blank?
		end
		{month_bill: month_bill}
	end

	def new_bill params
		value = Value.by_id(params[:value_id])
		value = value.value
		reading = params[:reading]
		prev_reading = params[:prev_reading]
		amount = (reading.to_f-prev_reading.to_f)*value.to_f
		bill = Bill.new(params[:bill].merge(amount: amount, status: '-1'))
		bill.save
	end

private
	def sum_up_month user, month, status
		place_bill = []
		month_bill = where("extract(month from created_at) = ? and user_id = ? and status #{status}", month, user.id).select("extract(month from created_at) as month, sum(cast(amount as float)) as amount").group("created_at").first
		if month_bill
			places = Bill.where("extract(month from created_at) = ? and user_id = ? and  status #{status}", month, user.id).uniq.select(:place_id).map(&:place_id)
			places.each do |place|
				sum_place = sum_up_place(user, month, place, status)
				place_bill << sum_place
			end
		month_bill[:place_bill] = place_bill
		month_bill
	end
		
	end

	def sum_up_place user, month, place_id, status
		service_bill = []
		place_bill = where("extract(month from created_at) = ? and user_id = ? and place_id = ? and status #{status}", month, user.id, place_id).select("sum(cast(amount as float)) as amount, place_id").group("place_id").first
		if place_bill
			services = Bill.where("extract(month from created_at) = ? and user_id = ? and place_id = ? and status #{status}", month, user.id, place_id).uniq.select(:service_id).map(&:service_id)
			services.each do |service|
				sum_service = sum_up_service user, month, place_id, service, status
				service_bill << sum_service
			end
			place_bill[:service_bill] = service_bill
			place_bill
		end
	end

	def sum_up_service user, month, place_id, service_id, status
		service_bill = where("extract(month from created_at) = ? and user_id = ? and place_id = ? and service_id = ? and status #{status}", month, user.id, place_id, service_id).select("sum(cast(amount as float)) as amount, service_id, status, max(created_at) as last_update_date").group("service_id, status").first
	end
end