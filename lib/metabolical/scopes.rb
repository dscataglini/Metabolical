module Metabolical
  module Scopes
    def self.included(klass)
        method = klass.respond_to?(:named_scope) ? :named_scope : :scope
        klass.send method, :with_meta, lambda{|k| {:joins => [:metas], :conditions => {"meta_data.key" => k}}}
        klass.send method, :with_metas, :includes => [:metas]
        klass.send method, :with_meta_data, lambda{|k, v| {:joins => [:metas], :conditions => {"meta_data.key" => k, "meta_data.data" => v.to_yaml}}}
        klass.send method, :without_meta, lambda{|k| 
          {:joins => [:metas], 
           :conditions => ["meta_data.metabolized_id not in (?)", 
           klass.send(:with_meta, k).all(:select => 'distinct(metabolized_id)').map(&:metabolized_id)]}
        }        
    end
    
    module AR3Scopes
      def self.included(klass)
        class_eval do
          scope :with_meta, lambda{|k| joins([:meta]).where({"meta_data.key" => k}) }
          scope :with_metas, includes(:meta)
          scope :with_meta_data, lambda{|k, v| joins(:meta).where("meta_data.key" => k, "meta_data.data" => v.to_yaml)}
        end
      end
    end
    
  end
end