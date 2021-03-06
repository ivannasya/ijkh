class FreelanceInterface::TagsController < FreelanceInterfaceController

	def show
		@tag = FreelanceInterface::Tag.find(params[:id])
		@tags =  FreelanceInterface::Tag.where(published: true).order('title asc')
		@freelancers = @tag.freelancers.where(published: true)

		@top_four_freelancers = FreelanceInterface::TopFourFreelancer.where(tag_id: params[:id])
		@top_four_count = 4 - @top_four_freelancers.size
	end


	def update
		@tag = FreelanceInterface::Tag.find(params[:id])
	 
	  	if @tag.update_attributes(params[:tag])
	    	render json: @tag.to_json
	  	else
		    render status: 500
		end
		# render json: params.to_json
	end 
end