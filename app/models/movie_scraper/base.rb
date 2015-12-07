require 'open-uri'

class MovieScraper::Base

  attr_accessor :movies, :doc

  def initialize
    @movies = []
  end

  def parse!
    @doc = get_html_doc
    get_movies
  end

  private

  def get_html_doc
    Nokogiri::HTML(open(get_url)) do |config|
      config.strict.nonet
    end
  end

  def update_existing_movies movies, store
    movies.where(stores: {'$ne' => store}).each do |m|
      m.stores.push(store)
      m.save
    end
  end
end
