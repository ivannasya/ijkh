# encoding: utf-8
class GtIntegrationWorker
	include Sidekiq::Worker

	def perform(user_id)
		services = Service.where("user_id = ? and vendor_id = 121 and is_active = true", user_id)
		services.each do |service|
			user_account = service.user_account

			gt = GlobalTelecom.new(user_account)
			amount = gt.check[:balance]

			if amount.to_f < 0.0
				amount = (amount.to_s)[1..-1] if amount.to_f < 0.0
				account = service.account
				account.update_attributes!(amount: amount, status: -1) if amount
			end
		end
	end

end