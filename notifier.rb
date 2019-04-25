# frozen_string_literal: true

require "pry"

#####
### Setup a YAML secret storage
#####
require "yaml"

SECRETS = begin
            YAML.load_file("secrets.yml")
          rescue StandardError
            {}
          end

#####
### Setup a Twilio Client
#####
require 'twilio-ruby'

TWILIO_CLIENT = Twilio::REST::Client.new(
  SECRETS.dig("twilio", "account_sid") || ENV['TWILIO_ACCOUNT_SID'],
  SECRETS.dig("twilio", "auth_token")  || ENV['TWILIO_AUTH_TOKEN']
  )

def send_text_message()
  puts TWILIO_CLIENT.messages.create(
    from: SECRETS.dig("twilio", "from_number")  || ENV['TWILIO_FROM_NUMBER'],
    to:   SECRETS.dig("twilio", "to_number")    || ENV['TWILIO_TO_NUMBER'],
    body: "You don't have to move your car tonight. Enjoy your evening!"
  )
end

#####
### Setup a Twitter API Client
#####
require "twitter"

TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = SECRETS.dig("twitter", "api_key")              || ENV["TWITTER_API_KEY"]
  config.consumer_secret     = SECRETS.dig("twitter", "api_secret_key")       || ENV["TWITTER_API_SECRET_KEY"]
  config.access_token        = SECRETS.dig("twitter", "access_token")         || ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = SECRETS.dig("twitter", "access_secret_token")  || ENV["TWITTER_ACCESS_SECRET_TOKEN"]
end

tweets = TWITTER_CLIENT.search("from:NYCASP", result_type: "recent").collect do |tweet|
  { tweet: tweet.text, date: tweet.created_at }
end

#####
### Decision whether to send a SMS about suspended rules
#####

if tweets[0][:tweet].include?('suspended')
  if tweets[0][:tweet].include?('tomorrow')
    # Send SMS to the user
    send_text_message()
    puts "SMS sent!"
  else
    puts "Suspended, but not tomorrow, SMS was not sent"
  end
else
  puts "Not suspended, SMS was not sent."
end
