require 'rails_helper'

RSpec.describe MovieScraper::VideoworldJob, type: :job, vcr: {record: :once} do

  it 'scrapes videoworld and creates Movie objects' do

    #MovieScraper::VideoworldJob.perform_now
  end
end
