class Tweet < ActiveRecord::Base
	extend FriendlyId
	require 'indico'

	before_save :downcase_fields
	friendly_id :handle, use: :slugged

	# return sentiment value.
	def self.get_senti_value(string)
		(Indico.sentiment_hq(string)*100).round(2)
	end

	#computation.
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

	# Not used. Purge later. 
	def self.get_tweets_json(tweets_array)
		arr = []
		tweets_array.each do |tweet|
			arr << tweet[1]
		end

		return arr
	end

	# downcase all query inputs before save.
	def downcase_fields
      self.handle.downcase!
   end
end
