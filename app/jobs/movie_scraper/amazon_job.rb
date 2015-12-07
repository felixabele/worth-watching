# Call me: MovieScraper::AmazonJob.perform_now
class MovieScraper::AmazonJob < ActiveJob::Base
  queue_as :default

  def perform
    az_scraper = MovieScraper::Amazon.new
    az_scraper.parse!
    az_scraper.save!
  end
end
