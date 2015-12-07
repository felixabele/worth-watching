# populates movie datasets from videoworld website
require 'open-uri'

class MovieScraper::Videoworld

  attr_accessor :movies, :pages, :doc, :current_page

  def initialize
    @movies = []
    @pages = 0
    @current_page = 0
  end

  def save!
    existing_movies = Movie.where(title: {'$in' => @movies.map(&:title)})
    existing_movies_title = existing_movies.pluck(:title)

    # update existing movies
    existing_movies.where(stores: {'$ne' => 'videoworld'}).each do |m|
      m.stores.push('videoworld')
      m.save
    end

    new_movies = @movies.reject{|m| existing_movies_title.find_index{|em| em == m.title}}
    Movie.collection.insert_many new_movies.map(&:as_document)
  end

  def parse!
    @doc = get_html_doc
    get_page_count
    get_movies
  end

  def parse_next_page
    if @current_page < @pages
      @current_page += 1
      parse!
    end
  end

  private

  def get_page_count
    @pages = @doc.xpath("//div[@id='blaettern']/a").count{|m| m.content.to_i > 0}
  end

  def get_movies
    @doc.xpath("//div[@id='neuheitenbox']").each do |mbox|
      movie_atts = mbox.xpath('div/div').map(&:content)

      @movies.push Movie.new({
        title: movie_atts[0],
        available_since: Date.parse(line_split(movie_atts[1])),
        genres: line_split(movie_atts[2]),
        country: line_split(movie_atts[3])[0],
        year: line_split(movie_atts[3])[1],
        description: movie_atts[5],
        stores: ['videoworld'],
      })
    end
  end

  def get_html_doc
    Nokogiri::HTML(open(get_url)) do |config|
      config.strict.nonet
    end
  end

  def get_url
    "http://www.videoworld.de/neuheiten-DVD-#{@current_page > 0 ? @current_page : ''}-/index.html"
  end

  # splits lines like "some-label: USA / 2013" into ["USA", "2013"]
  def line_split str
    content = str.split(': ')[1] || ''
    if content.match /\//
      content.split('/').map(&:strip).reject(&:empty?)
    else
      content
    end
  end
end
