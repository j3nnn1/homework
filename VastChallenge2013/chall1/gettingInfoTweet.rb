# 180 por 15min
# 720 por hora
require 'xmlsimple'
require 'twitter'
#require 'pp'

filename ='gatsby_5-7.xml'
config = XmlSimple.xml_in(filename)
tweet_ids = Array.new
fileout = File.new("twitter_gatsy.csv", "w")

config["node"].each do |val|
    tweet_ids << val["ID"][0].to_s()
end

Twitter.configure do |config|
  config.consumer_key = ''
  config.consumer_secret = ''
  config.oauth_token = ''
  config.oauth_token_secret = ''
end
def addquote(word)
    return "\"#{word}\""
end
save = Array.new

save = ["id_str", "created_at", "text", "source", "in_reply_to_status_id", "in_reply_to_user_id", "in_reply_to_screen_name", ];
save_user = ["description", "name", "id_str","screen_name", "location","followers_count", "friends_count", "listed_count", "created_at", "favourites_count", "time_zone", "geo_enabled", "verified", "statuses_count", "lang", "is_translator","profile_background_color", "retweet_count", "favorite_count", "contributors"]
save_entities_hashtag = ["text"]
save_entities_url = ["expanded_url"]

save_list = Array.new

header = 'id_str, created_at, text, source, in_reply_to_status_id, in_reply_to_user_id, in_reply_to_screen_name,user_description, user_name, user_id,user_screen_name, user_location,user_followers_count, user_friends_count, user_listed_count, user_created_at, user_favourites_count, user_time_zone, user_geo_enabled, user_verified, user_statuses_count, user_lang, user_is_translator,user_profile_background_color, user_retweet_count, user_favorite_count, user_contributors, hashtag_text, urls_expanded'

fileout.puts header

tweet_ids.each do |val|
	#fetch status
    begin   	
	    tweet = Twitter.status(val, {include_entities: "1"})
	    sleep(5)
		#saving
	    save.each do |val|
	       save_list.push(addquote(tweet[val].to_s().gsub('\n', '')))
	    end 

	    save_user.each do |val|
	       save_list.push(addquote(tweet["user"][val].to_s().gsub('\n', '')))
	    end 

	    save_entities_hashtag.each do |val|
		hashtags = Array.new
		tweet.hashtags.each do |j|
		hashtags.push(j[val])
		end
		save_list.push(addquote(hashtags.join(',').to_s().gsub('\n', '')))
	    end 

	    save_entities_url.each do |val|
		 urls = Array.new
		 tweet.urls.each do |k|
		 urls.push(k[val])
		 end
		 save_list.push(addquote(urls.join(',').to_s().gsub('\n', '')))
	    end 
	    line = save_list.join(';')
	    fileout.puts line
    rescue Exception => msg
        puts "#{msg} id #{val}"

    end
end





