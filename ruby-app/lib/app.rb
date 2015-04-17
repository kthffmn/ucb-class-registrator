class ClassChecker
  
  INTERESTED_CLASSES = ["sketch 301", "improv 101"]

  attr_reader :stream_client, :user
  attr_accessor :underline

  def self.run(user_id=289051336)
    @checker = self.new(user_id)
    @checker.start_following
  end

  def initialize(user_id)
    @stream_client = stream_client
    @user = get_user(user_id)
  end

  def stream_client
    TweetStream.configure do |config|
      config.consumer_key       = ENV["KEY"]
      config.consumer_secret    = ENV["SECRET"]
      config.oauth_token        = ENV["TOKEN"]
      config.oauth_token_secret = ENV["TOKEN_SECRET"]
      config.auth_method        = :oauth
    end
    TweetStream::Client.new
  end

  def rest_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["KEY"]
      config.consumer_secret     = ENV["SECRET"]
      config.access_token        = ENV["TOKEN"]
      config.access_token_secret = ENV["TOKEN_SECRET"]
    end
  end

  def start_following
    puts "Following #{self.user.name} (@#{self.user.screen_name})"
    i = 1
    stream_client.follow(self.user.id) do |status|
      puts "\n #{i}. #{status.text}\n"
      puts "  - #{Time.now.strftime("%l:%M %p")}"
      puts
      tweet = status.text.downcase
      right_class = false
      INTERESTED_CLASSES.each {|c| right_class = true if tweet.include?(c.downcase) }
      if right_class
        url = status.urls[0].attrs[:expanded_url]
        Launchy.open(url)
        InfoFetcher.run(url)
      end
      i += 1
    end
  end

  def get_user(user_id)
    self.rest_client.user(user_id)
  end

end
