class MeterReadingController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		@meter_readings = MeterReadingManager.get_by_tariff(TariffManager.get(params[:tariff_id]))
		render 'meter_reading/index'
	end

	def index_by_vendor
		@month = params[:meter_reading][:month]
		@meter_readings = MeterReading.where("extract(month from created_at) = ?", @month)
		meter_readings_array = []
		@meter_readings.each do |mr|
			service = ServiceManager.get(mr.service_id)
			mr[:user_account] = service.user_account
			meter_readings_array << mr if service.vendor_id == params[:meter_reading][:vendor_id].to_i
		end
		render json: {meter_reading: meter_readings_array}
	end

	def create
		@meter_reading = MeterReadingManager.create(current_user, params)
		render 'meter_reading/show'
	end

	def show_last
		@meter_reading = MeterReadingManager.get_last(params[:field_id])
		render 'meter_reading/show_last'
	end


end