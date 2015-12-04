class MovieInformation

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :genre_ids, type: Array
  field :original_language, type: String
  field :original_title, type: String
  field :popularity, type: Float
  field :title, type: String
  field :video, type: Boolean
  field :vote_average, type: Float
  field :vote_count, type: Integer

  embedded_in :movie

  def thumbnail_path
    image_path(0)
  end

  def image_path size=0
    if attribute_present?(:poster_path)
      conf = ApiConfiguration.load
      "#{conf.base_url}#{conf.poster_sizes[0]}#{poster_path}"
    end
  end

  # gets infos about a movie from TMDB-API
  def self.load_by_movie movie

    Tmdb::Api.key(Rails.application.secrets.tmdb_key)
    search = Tmdb::Search.new
    search.resource('movie')
    search.query(movie.title)

    if data = search.fetch.select {|info| (Date.parse(info['release_date']).year rescue 0) == movie.year}
      new(data.first)
    else
      EventLogger.log! "no information found", "could not find information for #{movie.title} from year: #{movie.year}"
      nil
    end
  end
end
