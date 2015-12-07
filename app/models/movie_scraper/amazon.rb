# populates movie datasets from amazon website
require 'open-uri'

class MovieScraper::Amazon < MovieScraper::Base

  attr_accessor :movies, :doc

  def save!
    existing_movies = Movie.where(title: {'$in' => @movies.map(&:title)})
    existing_movies_title = existing_movies.pluck(:title)

    update_existing_movies(existing_movies, 'amazon')

    new_movies = @movies.reject{|m| existing_movies_title.find_index{|em| em == m.title}}
    Movie.collection.insert_many new_movies.map(&:as_document)
  end

  private

  def get_movies
    @doc.css('.s-result-item').each do |mbox|

      published_year = mbox
        .css('.a-size-small')
        .map(&:text)
        .select{|el| el.match /^\d{4}$/ }.first.to_i

      if published_year > (Date.today.year - 3)
        @movies.push Movie.new({
          title: clean_title(mbox.css('h2').text),
          available_since: Date.today,
          year: published_year,
          stores: ['amazon'],
        })
      end
    end
  end

  def get_url
    "http://www.amazon.de/s/ref=atv_hm_hom_c_s9null_5_seemr?_encoding=UTF8&node=3010075031%2C3356018031&search-alias=prime-instant-video&sort=popularity-rank"
  end

  def clean_title title
    title.gsub(/\[.*\]/, '').strip
  end
end
