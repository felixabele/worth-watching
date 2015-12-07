require 'rails_helper'

RSpec.describe Movie, type: :model, vcr: {record: :once} do

  subject { build(:movie) }

  it 'creates a movie dataset' do
    expect(subject.year).to be 2015
    expect(subject.languages).to be_a Array
    expect(subject.available_since).to be < Date.today
  end

  it 'gets movie information from TMDB Database' do

    allow(MovieInformation).to receive(:load_by_movie) { build(:movie_information) }

    movie = create(:movie)
    movie.load_information

    expect(movie.information).to be_present
    expect(movie.last_information_update).to be_present
  end

  it 'use alternative title if no information is found' do
    movie = create(:movie, title: 'Eselscape Plan - Entkommen oder Sterben', title_alternatives: ['Escape Plan'])
    movie.load_information

    expect(movie.information).to be_present
    expect(movie.last_information_update).to be_present
  end
end
