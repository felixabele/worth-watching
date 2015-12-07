class MovieInformation

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :genre_ids, type: Array
  field :original_language, type: String
  field :original_title, type: String
  field :popularity, type: Float
  field :title, type: String
  field :overview, type: String
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

    movie_data = []
    movie.titles.each do |alt_title|
      movie_data = get_data_from_api(alt_title) if movie_data.empty?
    end

    if (data = movie_data.select {|info| (movie.year - (Date.parse(info['release_date']).year rescue 0)) < 3}).any?
      new(data.first)
    else
      EventLogger.log! "no information found", "could not find information for #{movie.title} from year: #{movie.year}"
      nil
    end
  end

  private

  def self.get_data_from_api title
    search = Tmdb::Search.new
    search.resource('movie')
    search.query(title)
    search.fetch
  end
end
