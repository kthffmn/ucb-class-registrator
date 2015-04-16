class ClassChecker

  BASE_URL = "http://ucbcomedy.com"
  SEARCH_URL = BASE_URL + "/global_search?global_query="
  
  INTERESTED_CLASSES = ["sketch 301", "improv 101"]

  attr_reader :client, :user_id
  attr_accessor :underline

  def self.run
    @checker = self.new
    @checker.start_following
  end

  def initialize(user_id=289051336)
    @client = client
    @user_id = user_id
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
    puts "Following @UCBClassesNYC"
    i = 1
    client.follow(user_id) do |status|
      puts "\n #{i}. #{status.text}\n"
      puts "  - #{Time.now.strftime("%l:%M %p")}\n"
      tweet = status.text.downcase
      right_class = false
      INTERESTED_CLASSES.each {|c| right_class = true if tweet.include?(c.downcase) }
      if right_class
        url = status.urls[0].attrs[:expanded_url]
        Launchy.open(url)
        get_class_info(url)
      end
      i += 1
    end
  end

  def get_class_info(url)
    html = save_html(url)
    class_title = print_title(html)
    print_class_times(html)
    open_teacher_page(class_title)
  end

  def save_html(url)
    Nokogiri::HTML(open(url))
  end

  def print_class_times(html)
    times = html.search("time")
    times.each do |time|
      class_number = time.parent.children.first.children.first.text
      class_time = time.children.first.text.gsub("EDT", "")
      puts "#{class_number}"
      puts "  #{class_time}"
    end
  end

  def print_title(html)
    class_title = html.search("h2").first.children.text
    build_underline(class_title)
    format_with_underline(class_title)
    class_title
  end

  def build_underline(class_title)
    self.underline = ""
    class_title.length.times { self.underline << "-" }
  end

  def open_teacher_page(class_title)
    name = fetch_teacher_name(class_title)
    url = search_for_url(name)
    Launchy.open(url)
  end

  def search_for_url(name)
    html = save_html(SEARCH_URL + URI.encode(name))
    people = html.search("h3")
    people.each do |person|
      person_name = person.children.first.text.downcase
      if person_name.include?(name.downcase)
        path = person.parent.parent.attributes["data-link"].value
        format_with_underline("#{name}'s Page Found!")
        return BASE_URL + path
      end
    end
    format_with_underline("No teacher(s) found")
    BASE_URL + "/talent/browse"
  end

  def format_with_underline(text)
    puts underline
    puts text
    puts underline
  end

  def fetch_teacher_name(class_title)
    last_number_i = class_title.rindex(/\d/)
    name = class_title[last_number_i + 1..-1]
    name[0] = "" if name[0] == " "
    name
  end

end
