require 'metabolical/meta_datum'
require 'metabolical/scopes'

module Metabolical
  def self.included(klass)
    klass.extend ClassMethods
  end  
  
  module ClassMethods
    def metabolize!
      if self.respond_to?(:named_scope)
        include Metabolical::AR3Scopes
      else
        include Metabolical::AR4Scopes
      end

      class_eval do
        has_many :metas, :as => :metabolized, :class_name => 'Metabolical::MetaDatum' do
          def [](key)
            owner = (self.respond_to?(:proxy_association) ? self.proxy_association.owner : self.proxy_owner)
            if owner.metas.loaded?
              owner.metas.detect{|m| m.key == key}
            else
              find_by_key(key) || owner.metas.detect{|m| m.key == key} || owner.metas.build(:key => key)
            end
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
