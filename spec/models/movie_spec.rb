require 'rails_helper'

RSpec.describe Movie, type: :model do

  subject { build(:movie) }

  it 'creates a movie dataset' do
    expect(subject.year).to be 2015
    expect(subject.languages).to be_a Array
    expect(subject.available_since).to be < Date.today
  end
end
