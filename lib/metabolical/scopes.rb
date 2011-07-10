module Metabolical
  module Scopes
    def self.included(klass)
        method = klass.respond_to?(:named_scope) ? :named_scope : :scope
        klass.send method, :with_meta, lambda{|k| {:joins => [:metas], :conditions => {"meta_data.key" => k}}}
        klass.send method, :with_metas, :includes => [:metas]
        klass.send method, :with_meta_data, lambda{|k, v| {:joins => [:metas], :conditions => {"meta_data.key" => k, "meta_data.data" => v.to_yaml}}}
        klass.send method, :without_meta, lambda{|k| 
          {:joins => "left join meta_data md on md.metabolized_id = #{klass.table_name}.#{klass.primary_key} and md.metabolized_type = '#{klass.to_s}' and md.key = '#{k}'", :conditions => "md.metabolized_id is null"}
        }        
    end
    
    module AR3Scopes
      def self.included(klass)
        class_eval do
          scope :with_meta, lambda{|k| joins([:meta]).where({"meta_data.key" => k}) }
          scope :with_metas, includes(:meta)
          scope :with_meta_data, lambda{|k, v| joins(:meta).where("meta_data.key" => k, "meta_data.data" => v.to_yaml)}
          # TODO: find a better way to define this
          # Arel provides a way to specify left joins by using
          # join(left).on(... syntax
          scope :without_meta, lambda{|k| {:joins => "left join meta_data md on md.metabolized_id = #{klass.table_name}.#{klass.primary_key} and md.metabolized_type = '#{klass.to_s}' and md.key = '#{k}'", :conditions => "md.metabolized_id is null"}
          }
        end
      end
    end
    
  end
end
