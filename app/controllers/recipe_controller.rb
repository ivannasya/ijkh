class RecipeController < ApplicationController
	def create
		@recipe = RecipeManager.new
		@recipe.create(ServiceManager.get(params[:service_id]), params[:amount])
		render 'recipe/show'
	end

	def show_last
		@recipe = RecipeManager.show_last(current_user, params[:service_id])
		render 'recipe/show'
	end
end