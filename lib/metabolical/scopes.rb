module Metabolical
  module AR4Scopes
    def self.included(klass)
      class_eval do
        klass.send :scope, :with_meta,      lambda {|k| joins(:metas).where("meta_data.key" => k) }
        klass.send :scope, :with_metas,     lambda { include(:metas) }
        klass.send :scope, :with_meta_data, lambda{|k, v| where({"meta_data.key" => k, "meta_data.data" => v.to_yaml}).joins(:metas) }
        klass.send :scope, :without_meta,   lambda{|k|
          joins("left join meta_data md on md.metabolized_id = #{klass.table_name}.#{klass.primary_key} and md.metabolized_type = '#{klass.to_s}' and md.key = '#{k}'").where("md.metabolized_id is null")
        }
      end
    end
  end

  module AR3Scopes
    def self.included(klass)
      class_eval do
        klass.send :named_scope, :with_meta, lambda{|k| joins([:meta]).where({"meta_data.key" => k}) }
        klass.send :named_scope, :with_metas, includes(:meta)
        klass.send :named_scope, :with_meta_data, lambda{|k, v| joins(:meta).where("meta_data.key" => k, "meta_data.data" => v.to_yaml)}
        # TODO: find a better way to define this
        # Arel provides a way to specify left joins by using
        # join(left).on(... syntax
        klass.send :named_scope, :without_meta, lambda{|k| {:joins => "left join meta_data md on md.metabolized_id = #{klass.table_name}.#{klass.primary_key} and md.metabolized_type = '#{klass.to_s}' and md.key = '#{k}'", :conditions => "md.metabolized_id is null"}
        }
      end
    end
  end
end
