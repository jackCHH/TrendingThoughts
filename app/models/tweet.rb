class Tweet < ActiveRecord::Base
	extend FriendlyId
	require 'indico'

	before_save :downcase_fields
	friendly_id :handle, use: :slugged

	def self.get_senti_value(string)
		(Indico.sentiment_hq(string)*100).round(2)
	end

	def downcase_fields
      self.handle.downcase!
   end
end
