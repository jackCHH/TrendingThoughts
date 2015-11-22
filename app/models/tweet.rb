class Tweet < ActiveRecord::Base
	extend FriendlyId
	require 'indico'

	before_save :downcase_fields
	friendly_id :handle, use: :slugged

	def self.get_senti_value(string)
		(Indico.sentiment_hq(string)*100).round(2)
	end

	def self.get_tweets_array(tweets)

		arr = Array.new(50){Array.new(3)}
		threads = []

		count = 0

		tweets.take(50).each do |tweet|
			arr[count][0] = tweet.text
			arr[count][2] = tweet.created_at
			#arr[count][1] = get_senti_value(tweet.text)
			count += 1
		end

		threads << Thread.new {
			(0..9).each do |i|
				arr[i][1] = get_senti_value(arr[i][0])
			end
		}
		threads << Thread.new {
			(10..19).each do |i|
				arr[i][1] = get_senti_value(arr[i][0])
			end
		}
		threads << Thread.new {
			(20..29).each do |i|
				arr[i][1] = get_senti_value(arr[i][0])
			end
		}
		threads << Thread.new {
			(30..39).each do |i|
				arr[i][1] = get_senti_value(arr[i][0])
			end
		}
		threads << Thread.new {
			(40..49).each do |i|
				arr[i][1] = get_senti_value(arr[i][0])
			end
		}

		threads.each(&:join)

		return arr

		
		

	end

	def downcase_fields
      self.handle.downcase!
   end
end
