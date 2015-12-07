require 'rails_helper'

RSpec.describe MovieScraper::Amazon, vcr: {record: :once} do

  subject { MovieScraper::Amazon.new }

  before do
    html_doc = Nokogiri::HTML(File.open(Rails.root.join('./spec/fixtures/websites/amazon.de.html')))
    allow(subject).to receive(:get_html_doc).and_return(html_doc)
    subject.parse!
  end

  describe 'opens Amazon.de' do

    it 'gets movies' do
      expect(subject.movies.count).to be > 0
    end

    it 'parses data into Movie Objects' do
      movie = subject.movies.first
      expect(movie.title).to eq 'Beyond the Lights'
      expect(movie.year).to eq 2015
      movie.load_information
      expect(movie.description).to match 'Seit ihrer Kindheit wird Noni Jean auf eine Karriere als Sängerin vorbereitet.'
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
