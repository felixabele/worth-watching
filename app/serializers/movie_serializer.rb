class MovieSerializer < ActiveModel::MongoidSerializer
  attributes :id, :title, :information, :available_since, :path

  def information
    MovieInformationSerializer.new(object.information).serializable_hash
  end

  def path
    movie_path(object)
  end
end
