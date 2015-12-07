class ApiConfiguration

  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :base_url,        type: String
  field :secure_base_url, type: String
  field :poster_sizes,    type: Array
  field :backdrop_sizes,  type: Array
  field :profile_sizes,   type: Array
  field :logo_sizes,      type: Array

  def self.load
    @@config ||=
      if (config = self.first) && config.updated_at > 1.week.ago
        config
      else
        self.create_or_update
      end
  end

  def self.create_or_update

    config_resource = Tmdb::Configuration.new
    new_config = self.new

    %w(base_url secure_base_url poster_sizes backdrop_sizes profile_sizes logo_sizes).each do |field|
      new_config[field.to_sym] = config_resource.send(field.to_sym)
    end

    self.delete_all
    new_config.save!
    EventLogger.log! "new config"

    return new_config
  end
end
