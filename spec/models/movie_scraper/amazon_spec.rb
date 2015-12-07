require 'rails_helper'

RSpec.describe MovieScraper::Amazon do

  subject { MovieScraper::Amazon.new }

  before do
    # http://www.amazon.de/s/ref=atv_hm_hom_c_s9null_5_seemr?_encoding=UTF8&node=3010075031%2C3356018031%2C4190509031&pf_rd_i=home&pf_rd_m=A3JWKAKR8XB7XF&pf_rd_p=776434627&pf_rd_r=0CMGCSDSY9E49R4W0M2J&pf_rd_s=center-6&pf_rd_t=12401&search-alias=prime-instant-video&sort=popularity-rank
    html_doc = Nokogiri::HTML(File.open(Rails.root.join('./spec/fixtures/websites/amazon.de.html')))
    allow(subject).to receive(:get_html_doc).and_return(html_doc)
    subject.parse!
  end

  describe 'opens Amazon.de' do

    it 'gets total page count' do
      expect(subject.pages).to be > 0
    end

    it 'gets movies' do
      expect(subject.movies.count).to be > 0
    end

    it 'parses data into Movie Objects' do
      movie = subject.movies.first
      expect(movie.title).to eq 'Beyond the Lights'
      #expect(movie.available_since.to_s).to eq '2015-11-05'
      expect(movie.genres.length).to be 1
      expect(movie.year).to eq 2015
      expect(movie.description).to match 'die alle Voraussetzungen besitzt, ein Superstar zu werden'
    end

    it 'saves all movies into database' do
      subject.save!
      expect(Movie.count).to be 60
    end

    it 'does not save movies twice' do
      subject.save!
      subject.save!
      expect(Movie.count).to be 60
    end
  end
end
