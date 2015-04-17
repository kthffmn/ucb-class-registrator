class InfoFetcher

  BASE_URL = "http://ucbcomedy.com"
  SEARCH_URL = BASE_URL + "/global_search?global_query="

  attr_reader :url
  attr_accessor :html, :class_title, :underline, :teacher, :teacher_url

  def self.run(url)
    finder = self.new(url)
    finder.get_class_info
  end

  def initialize(url)
    @url = url
    @html = ""
    @class_title = ""
    @teacher = ""
    @underline = ""
    @teacher_url = ""
  end

  def get_class_info
    save_html
    save_class_title
    build_underline
    format_with_underline(class_title)
    print_class_times
    open_teacher_page
  end

  def save_html
    self.html = Nokogiri::HTML(open(url))
  end

  def print_class_times
    times = html.search("time")
    times.each do |time|
      class_number = time.parent.children.first.children.first.text
      class_time = time.children.first.text.gsub("EDT", "")
      puts "#{class_number}"
      puts "  #{class_time}"
    end
  end

  def save_class_title
    self.class_title = html.search("h2").first.children.text
  end

  def build_underline
    class_title.length.times { self.underline << "-" }
  end

  def open_teacher_page
    self.teacher = fetch_teacher_name
    self.teacher_url = search_for_url
    Launchy.open(teacher_url)
  end

  def search_for_url
    html.search("h3").each do |person|
      person_name = person.children.first.text.downcase
      binding.pry
      if person_name.include?(teacher.downcase)
        path = person.parent.parent.attributes["data-link"].value
        format_with_underline("#{teacher}'s page found!")
        return BASE_URL + path
      end
    end
    format_with_underline("#{teacher}'s page not found")
    BASE_URL + "/talent/browse"
  end

  def format_with_underline(text)
    puts underline
    puts text
    puts underline
  end

  def fetch_teacher_name
    last_number_i = class_title.rindex(/\d/)
    name = class_title[last_number_i + 1..-1]
    name[0] = "" if name[0] == " "
    name
  end
end
