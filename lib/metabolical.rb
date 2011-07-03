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
            find_by_key(key) || self.proxy_owner.metas.detect{|m| m.key == key}
          end
          
          def []=(key, data)
            meta = self[key] || self.proxy_owner.metas.build(:key => key)
            meta.data = data
            meta
          end
        end
      end
    end
  end
    
end
