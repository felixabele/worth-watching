require 'spec_helper'

describe Api::MoviesController, type: :controller do

  let(:movie) { create(:movie) }

  it 'returns valid JSON data' do
    get :index
    expect(response).to be_success
  end
end
