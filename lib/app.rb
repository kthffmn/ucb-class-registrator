class ClassChecker
  attr_reader :client

  def self.run
    @checker = self.new
    @checker.start_following
  end

  def initialize
    @client = client
  end

  def client
    TweetStream.configure do |config|
      config.consumer_key       = ENV["KEY"]
      config.consumer_secret    = ENV["SECRET"]
      config.oauth_token        = ENV["TOKEN"]
      config.oauth_token_secret = ENV["TOKEN_SECRET"]
      config.auth_method        = :oauth
    end
    TweetStream::Client.new
  end

  def start_following
    client.follow(289051336) do |status|
      binding.pry
      if status.text.downcase.include?("sketch 301")
        match = status.text.match(/.*(?<productlink>http:\/\/.{15})./)
        Launchy.open(match[:productlink])
      end
    end
  end

end