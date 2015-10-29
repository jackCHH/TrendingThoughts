class TweetsController < ApplicationController

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweets_params)
		if @tweet.save
			redirect_to @tweet
		else
			render 'new'
		end
	end

	def show
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key = ENV['twitter_consumer_key']
		  config.consumer_secret = ENV['twitter_consumer_secret']
		  config.access_token = ENV['twitter_access_token']
		  config.access_token_secret = ENV['twitter_access_secret']
		end

		@tweet = Tweet.find(params[:id])
		
	end

	private

	def tweets_params
		params.require(:tweet).permit(:handle)
	end
end
