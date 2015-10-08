class VideosController < ApplicationController
	before_action :set_video, only: [:show]
	before_filter :require_user

	def index
		@videos = Video.all

		@categories = []

		Video.all.each do |video|
			@categories << video.category
			@categories.uniq!
		end

		#binding.pry

	end

	def show
		@reviews = @video.reviews
	end

	def search
  	@results = Video.search_by_title(params[:search_term])
  end

	private

	def video_params
    params.require(:video).permit(:title, :description, :small_cover_url, :large_cover_url, :search_term)
  end
  
  def set_video
    @video = Video.find(params[:id])
  end


end