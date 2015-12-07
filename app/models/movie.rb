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
  field :title_alternatives, type: Array, default: []
  field :year, type: Integer
  field :last_information_update, type: DateTime

  index title: 1

  embeds_one :information, class_name: "MovieInformation"

  scope :with_information, -> { where(:"information".exists => true) }

  def titles
    title_alternatives.dup.push(title)
  end

  def description
    read_attribute(:description) || (information.present? ? information.overview : '')
  end

  def load_information force=false
    if force || (last_information_update.nil? || last_information_update < 7.days.ago)

      if movie_info = MovieInformation.load_by_movie(self)
        self.update_attributes({
          information: movie_info,
          last_information_update: Time.now
        })
        EventLogger.log! "Updated information", "for movie: '#{self.title}'", {id: self.id}
      end
    end
    information
  end

  def moviedb_path
    if information.present?
      "https://www.themoviedb.org/movie/#{information._id}"
    end
  end
end
