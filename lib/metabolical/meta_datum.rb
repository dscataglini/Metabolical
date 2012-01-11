require 'active_record/version'
module Metabolical
  class MetaDatum < ActiveRecord::Base
    belongs_to :metabolized, :polymorphic => true
    if Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new("3.1.0")
      serialize :data
    else
      def data=(val)
        write_attribute(:data, val.to_yaml)
      end

      def data
        read_attribute(:data).blank? ? nil : YAML.load(read_attribute(:data))
      end
    end
  end
end