class Movie

  include Mongoid::Document
  include Mongoid::Timestamps

  field :available_since, type: Date
  field :country, type: String
  field :description, type: String
  field :genres, type: Array
  field :languages, type: Array
  field :stores, type: Array
  field :title, type: String
  field :year, type: Integer
  field :last_information_update, type: DateTime

  index title: 1

  embeds_one :information, class_name: "MovieInformation"

  scope :with_information, -> { where(:"information".exists => true) }

  def load_information
    if last_information_update.nil? || last_information_update < 7.days.ago
      self.update_attributes({
        information: MovieInformation.load_by_movie(self),
        last_information_update: Time.now})

      EventLogger.log! "Updated information", "for movie: '#{self.title}'", {id: self.id}
    end
    information
  end
end
