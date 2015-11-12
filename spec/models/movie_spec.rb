require 'rails_helper'

RSpec.describe Movie, type: :model do

  subject { build(:movie) }
  before do
    allow(MovieInformation).to receive(:load_by_movie) { build(:movie_information) }
  end

  it 'creates a movie dataset' do
    expect(subject.year).to be 2015
    expect(subject.languages).to be_a Array
    expect(subject.available_since).to be < Date.today
  end

  it 'gets movie information from TMDB Database' do
    movie = create(:movie)
    movie.load_information

    expect(movie.information).to be_present
    expect(movie.last_information_update).to be_present
  end
end
