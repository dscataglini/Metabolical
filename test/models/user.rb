require 'metabolical'
class User < ActiveRecord::Base
  include Metabolical
  metabolize!
end