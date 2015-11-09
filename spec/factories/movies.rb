FactoryGirl.define do
  factory :movie do
    available_since { 2.month.ago }
    country 'Italy'
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"
    genres ['commedy']
    languages ['de', 'en']
    stores ['lovefilm', 'videoworld']
    title "Consectetur Adipisicing"
    year 2015
  end

end
