# encoding: utf-8
class SlPaymentWorker
	include Sidekiq::Worker

	def perform(service_id, recipe_id, amount)
		services = Service.find(service_id)
		user_account = service.user_account
		sl = SamaraLan.new(user_account, recipe_id, amount)
		sl.pay
	end

end