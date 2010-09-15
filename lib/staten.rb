class Staten
  include Mongoid::Document
  include Mongoid::Timestamps

  field :states, :type => Array
  field :events, :type => Hash
end
