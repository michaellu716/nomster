class PlacesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		# @places = Place.all
		# @places = Place.paginate(page: params[:page])
		
		@places = Place.order("name").page(params[:page]).per_page(8)
		@placesLast = Photo.last
		#place_path(place)
		# @photo = Photo.where(place_id: placesLast).last.picture.url
	end

	def new
		@place = Place.new
	end

	def create
		# @place = current_user.places.create(place_params)
		# #validate all fields are filled out, if not through error
		# if @place.invalid?
  #   		flash[:error] = %Q[All fields are required, go back and fill out all fields! <a href="/places/new">Go Back</a>]
  # 		end
		# redirect_to root_path
		@place = current_user.places.create(place_params)
  		if @place.valid?
   		 	redirect_to root_path
  		else
  		    render :new, status: :unprocessable_entity
  		end
	end

	def show
		@place = Place.find(params[:id])
		@comment = Comment.new
		@photo = Photo.new
	end

	def edit
		@place = Place.find(params[:id])
		#user validation
		if @place.user != current_user
			return rendor plain: 'Not Allowed', status:  :forbidden
		end
	end

	def update
  		@place = Place.find(params[:id])
  		#user validation
  		if @place.user != current_user
   		    return render plain: 'Not Allowed', status: :forbidden
  		end

  		@place.update_attributes(place_params)
  		if @place.valid?
   		   redirect_to root_path
        else
     		render :edit, status: :unprocessable_entity
  		end
 	end

	def destroy
		@place = Place.find(params[:id])
		#user validation
		if @place.user != current_user
    		return render plain: 'Not Allowed', status: :forbidden
  		end
		@place.destroy
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end

end
