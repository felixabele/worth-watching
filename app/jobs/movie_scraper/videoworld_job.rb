class MovieScraper::VideoworldJob < ActiveJob::Base
  queue_as :default

  def perform
    vw_scraper = MovieScraper::Videoworld.new
    vw_scraper.parse!

    while vw_scraper.current_page < vw_scraper.pages do
      vw_scraper.parse_next_page
    end

    vw_scraper.save!
  end
end
