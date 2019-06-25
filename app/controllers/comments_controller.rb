class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def create
        @place = Place.find(params[:place_id])
   		@place.comments.create(comment_params.merge(user: current_user))
    	redirect_to place_path(@place)
 	end

 	def edit
      @comment = Comment.find(params[:id])
      if @comment.user != current_user
         return render text: "Not Allowed", status: :forbidden
      end
 	end

 	def new
		@comment = Comment.new
	end

 	def show
 		@comment = Comment.find(params[:id])
 	end

 	def update
      @comment = Comment.find(params[:id])
	  if @comment.user != current_user
   		    return render plain: 'Not Allowed', status: :forbidden
  	  end

  	  @comment.update_attributes(comment_params)
  	  if @comment.valid?
   		   redirect_to root_path
      else
     	   render :edit, status: :unprocessable_entity
  	  end
 	end


	def destroy
		@comment = Comment.find(params[:id])
		#user validation
		if @comment.user != current_user
    		return render plain: 'Not Allowed', status: :forbidden
  		end
		@comment.destroy
		redirect_to root_path
	end
 	
	private

	def comment_params
		params.require(:comment).permit(:message, :rating)
	end
end
