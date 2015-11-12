class UpdateMovieInformationJob < ActiveJob::Base
  queue_as :default

  # updates movie information for all moviews for the first time
  # request limits are 40 requests every 10 seconds
  def perform
    Movie.where(last_information_update: nil).each do |movie|
      movie.load_information
      sleep 0.5
    end
  end
end
