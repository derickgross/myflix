class CategoriesController < ApplicationController

	def index
		@videos = Video.all
		@categories = Category.all
	end

	def create

	end

	def show
		@categories = Category.all
	end

end