require 'rails_helper'

RSpec.describe MovieScraper::Videoworld, vcr: {record: :once} do

  subject { MovieScraper::Videoworld.new }

  before do
    html_doc = Nokogiri::HTML(File.open(Rails.root.join('./spec/fixtures/websites/videoworld.de.html')))
    allow(subject).to receive(:get_html_doc).and_return(html_doc)
    subject.parse!
  end

  describe 'opens Videoworld.de' do

    it 'gets total page count' do
      expect(subject.pages).to be > 0
    end

    it 'gets movies' do
      expect(subject.movies.count).to be > 0
    end

    it 'parses data into Movie Objects' do
      movie = subject.movies.first
      expect(movie.title).to eq 'Abschussfahrt - Vier ist einer zu voll'
      expect(movie.available_since.to_s).to eq '2015-11-05'
      expect(movie.genres.length).to be 1
      expect(movie.country).to eq 'Deutschland'
      expect(movie.year).to eq 2015
      expect(movie.description).to match 'Schul-Nerds'
    end

    it 'saves all movies into database' do
      subject.save!
      expect(Movie.count).to be 10
    end

    it 'does not save movies twice' do
      subject.save!
      subject.save!
      expect(Movie.count).to be 10
    end
  end
end
