class MovieSerializer < ActiveModel::MongoidSerializer
  attributes :id, :title, :information, :available_since, :path, :edit_path

  def information
    MovieInformationSerializer.new(object.information).serializable_hash
  end

  def path
    movie_path(object)
  end

  def edit_path
    edit_movie_path(object)
  end
end
