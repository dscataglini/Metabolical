require 'metabolical/meta_datum'
require 'metabolical/scopes'

module Metabolical
  def self.included(klass)
    klass.extend ClassMethods
  end  
  
  module ClassMethods
    def metabolize!
      include Metabolical::Scopes
      class_eval do
        has_many :metas, :as => :metabolized, :class_name => 'Metabolical::MetaDatum' do
          def [](key)
            owner = (self.respond_to?(:proxy_association) ? self.proxy_association.owner : self.proxy_owner)
            find_by_key(key) || owner.metas.detect{|m| m.key == key} || owner.metas.build(:key => key)
          end
          
          def []=(key, data)
            owner = (self.respond_to?(:proxy_association) ? self.proxy_association.owner : self.proxy_owner)
            meta = self[key]
            meta.data = data
            meta.save unless owner.new_record?
            meta
          end
        end
      end
      
    end
  end
    
end
