class TariffTemplateController < ApplicationController
	def index
		@tariff_templates = TariffTemplate.where(service_type_id: params[:service_type_id])

		render 'tariff_template/index'
	end

	def show
		@tariff_template = TariffTemplate.select("id, title, has_readings").where(id: params[:tariff_id])
	end
end