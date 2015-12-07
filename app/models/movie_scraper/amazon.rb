# populates movie datasets from videoworld website
require 'open-uri'

class MovieScraper::Amazon

  attr_accessor :movies, :doc

  def initialize
    @movies = []
  end

  def save!
    existing_movies = Movie.where(title: {'$in' => @movies.map(&:title)})
    existing_movies_title = existing_movies.pluck(:title)

    # update existing movies
    existing_movies.where(stores: {'$ne' => 'amazon'}).each do |m|
      m.stores.push('amazon')
      m.save
    end

    new_movies = @movies.reject{|m| existing_movies_title.find_index{|em| em == m.title}}
    Movie.collection.insert_many new_movies.map(&:as_document)
  end

  def parse!
    @doc = get_html_doc
    get_movies
  end

  private

  def get_movies
    @doc.css('.s-result-item').each do |mbox|
      @movies.push Movie.new({
        title: clean_title(mbox.css('h2').text),
        available_since: Date.today,
        year: mbox.css('.a-size-small').map(&:text).select{|el| el.match /^\d{4}$/ }.first,
        stores: ['amazon'],
      })
    end
  end

  def get_html_doc
    Nokogiri::HTML(open(get_url)) do |config|
      config.strict.nonet
    end
  end

  def get_url
    "http://www.amazon.de/s/ref=atv_hm_hom_c_s9null_5_seemr?_encoding=UTF8&node=3010075031%2C3356018031%2C4190509031&pf_rd_i=home&pf_rd_m=A3JWKAKR8XB7XF&pf_rd_p=776434627&pf_rd_r=0CMGCSDSY9E49R4W0M2J&pf_rd_s=center-6&pf_rd_t=12401&search-alias=prime-instant-video&sort=popularity-rank"
  end

  def clean_title title
    title.gsub(/\[.*\]/, '').strip
  end
end
