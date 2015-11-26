class AddCounterToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :counter, :integer
  end
end
