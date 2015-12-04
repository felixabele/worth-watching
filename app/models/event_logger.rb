class EventLogger

  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :event,   type: String
  field :message, type: String
  field :data,    type: Hash
  field :caller,  type: Hash

  def self.log! event, message="", data={}
    log = self.new(event: event, message: message, data: data)
    log.set_caller(caller)
    log.save!
  end

  def set_caller caller
    if caller_arr = caller.first.split(":")
      self.caller = {
        file: caller_arr[0].sub(Rails.root.to_s, ''),
        line: caller_arr[1]
      }
    end
  end
end
