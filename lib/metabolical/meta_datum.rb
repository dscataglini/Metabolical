module Metabolical
  class MetaDatum < ActiveRecord::Base
    belongs_to :metabolized, :polymorphic => true
    serialize :data
  end
end