class MovieInformationSerializer < ActiveModel::MongoidSerializer
  attributes :vote_average, :vote_count

end
