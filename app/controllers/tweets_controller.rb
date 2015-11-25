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
		current_tweets = $client.search("#{@tweet.handle} -rt", result_type: "recent", lang: "en")

		@tweets_array = Tweet.get_tweets_array(current_tweets)

		tweets_array_val_json = Tweet.get_tweets_json(@tweets_array)
		gon.senti_array = tweets_array_val_json

	end

	private

	def tweets_params
		params.require(:tweet).permit(:handle)
	end
end
