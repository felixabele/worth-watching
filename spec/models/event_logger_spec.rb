require 'rails_helper'

RSpec.describe EventLogger, type: :model do

  before do
    EventLogger.delete_all
  end

  it 'loggs an event' do

    EventLogger.log! 'test-event', 'this is my message', {answer: 42}

    log = EventLogger.first
    expect(EventLogger.count).to be 1
    expect(log.event).to eq 'test-event'
    expect(log.message).to eq 'this is my message'
    expect(log.data[:answer]).to be 42
    expect(log.caller).to be_a Hash
    expect(log.caller[:file]).to eq '/spec/models/event_logger_spec.rb'
  end
end
