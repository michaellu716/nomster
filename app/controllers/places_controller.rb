class PlacesController < ApplicationController
	def index
		# @places = Place.all
		# @places = Place.paginate(page: params[:page])
		@places = Place.page(params[:page]).per_page(3)
	end

	def new
		@place = Place.new
	end

	def create
		@place = Place.create(place_params)
		#validate all fields are filled out, if not through error
		if @place.invalid?
    		# flash[:error] = "Please reset your password #{view_context.link_to 'here', new_place_path}."
    		flash[:error] = %Q[All fields are required, go back and fill out all fields! <a href="/places/new">Go Back</a>]
  		end
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end

end
