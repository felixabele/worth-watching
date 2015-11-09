require 'rails_helper'

RSpec.describe MovieScraper::VideoworldJob, type: :job do

  it 'scrapes videoworld and creates Movie objects' do

    pending ' TODO: create a test that does not use network'
    #MovieScraper::VideoworldJob.perform_now
  end
end
