class SearchController < ApplicationController

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'post'
			@records = Post.search_for(@content, @method)
		else
			@records = Column.search_for(@content, @method)
		end
	end
end
