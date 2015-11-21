class TweetsController < ApplicationController
	require 'indico'

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweets_params)

		if Tweet.exists?(:handle => @tweet.handle)
			@original_tweet = Tweet.find_by_handle(@tweet.handle)
			redirect_to @original_tweet
		elsif @tweet.save
			redirect_to @tweet
		else
			render 'new'
		end
	end

	def show
		Indico.api_key = ENV["indico_key"]
		@tweet = Tweet.friendly.find(params[:id])
	end

	private

	def tweets_params
		params.require(:tweet).permit(:handle)
	end
end
