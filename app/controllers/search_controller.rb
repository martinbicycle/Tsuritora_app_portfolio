class SearchController < ApplicationController

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'post'
			@records = Post.search_for(@content, @method)

		elsif @model == 'column'
			@records = Column.search_for(@content, @method)
		elsif @model == 'tag'
			tag_ids = Tag.search_for(@content, @method).pluck(:id)
			post_ids = PostTag.where(tag_id: tag_ids).pluck(:post_id)
			@records = Post.where(id: post_ids)
		end
	end
end
