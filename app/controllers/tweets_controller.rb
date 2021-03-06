class TweetsController < ApplicationController
	require 'indico'

	def new
		@tweet = Tweet.new

		#following only works with Postgres
		@random_tweet = Tweet.order("RANDOM()").first

		@top_tweets = Tweet.limit(5).order('counter desc')

	end

	def create
		@tweet = Tweet.new(tweets_params)

		if Tweet.exists?(:handle => @tweet.handle)
			@original_tweet = Tweet.find_by_handle(@tweet.handle)
			@original_tweet.increment!(:counter)
			redirect_to @original_tweet
		elsif @tweet.save
			@tweet.increment!(:counter)
			redirect_to @tweet
		else
			render 'new'
		end

	end

	def show

		Indico.api_key = ENV["indico_key"]

		#retreive tweets from Twitter server
		@tweet = Tweet.friendly.find(params[:id])
		current_tweets = $client.search("#{@tweet.handle} -rt", result_type: "recent", lang: "en")

		# send all current tweets to model and do computation.
		@tweets_array = Tweet.get_tweets_array(current_tweets)

		# sends back to javascript
		tweets_array_val_json = Tweet.get_tweets_json(@tweets_array)
		gon.senti_array = tweets_array_val_json

	end

	private

	def tweets_params
		params.require(:tweet).permit(:handle)
	end
end
