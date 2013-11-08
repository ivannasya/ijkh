#!/bin/env ruby
# encoding: utf-8
class AccountController < ApplicationController
	def index
	end

	def autoset
		BalanceSetterWorker.perform_async(params)
		render json: {status: "success"}
	end

	def new_recurrent
		@account = AccountManager.new_recurrent(ServiceManager.get(params[:service_id]))
		render 'account/show'
	end

	def hand_switch
		@account = AccountManager.hand_switch(current_user, AccountManager.get(params[:account_id]), params[:amount])
		render json: {status: "updated"}
	end
	
	def paid_index
		@place_accounts = Account.index_place_account current_user, "= 1"
		render 'place_account/index'
	end

	def unpaid_index
		JtIntegrationWorker.perform_async(current_user.id)
		@place_accounts = Account.index_place_account current_user, "!= 1"
		render 'place_account/index'
	end

	def switch_account_status
		#params.merge!(user_id: current_user.id)
		#@account = Account.switch_status params
		render 'account/show'
	end
	
	def destroy
		AccountManager.delete(params[:account_id])
		render json: {status: "deleted"}
	end
end