# encoding: utf-8
class FreelanceInterface::CommentsController < FreelanceInterfaceController

	def show
		
	end

	def create
		comment_params = {
			published: false,
			body: params[:freelance_interface_comment][:body],
			freelancer_id: params[:freelance_interface_comment][:freelancer_id]
		}

		@comment = FreelanceInterface::Comment.create(comment_params)

		@message = "Комментарий отправлен на модерацию"

		if @comment.save 
			respond_to do |format|
				format.js {render 'freelance_interface/comments/create'}
			end
			return nil
		else
			@message = "nothing happend"
			respond_to do |format|
				format.js {render 'freelance_interface/comments/error'}
			end
			return nil
		end
	end

	def update
		@comment = FreelanceInterface::Comment.find(params[:id])
	 
	  	if @comment.update_attributes(params[:comment])
	    	render json: @comment
	  	else
		    render status: 500
		end
		# render json: params.to_json
	end 
end