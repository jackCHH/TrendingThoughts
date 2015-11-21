class AddSlugToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :slug, :string, unique: true
  end
end
