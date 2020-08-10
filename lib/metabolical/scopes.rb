module Metabolical
  module Scopes
    def self.included(klass)
      klass.send :scope, :with_meta,  lambda{|k| joins([:metas]).where({"meta_data.key" => k}) }
      klass.send :scope, :with_metas, lambda{ includes(:metas) }
      klass.send :scope, :with_meta_data, lambda{|k, v| joins(:metas).where("meta_data.key" => k, "meta_data.data" => v.to_yaml) }
        # TODO: find a better way to define this
        # Arel provides a way to specify left joins by using
        # join(left).on(... syntax
      klass.send :scope, :without_meta, lambda{|k| 
        # DS: this is the arel way. 
          # klass.arel_table
          #   .join(MetaDatum.arel_table, Arel::Nodes::OuterJoin)
          #   .on(klass.arel_table[:id].eq(MetaDatum.arel_table[:metabolized_id]).and(MetaDatum.arel_table[:metabolized_type].eq(klass.to_s)).and(MetaDatum.arel_table[:key].eq(k)))
          #   .where(MetaDatum.arel_table[:metabolized_id].eq(nil))
        
          where("md.metabolized_id" => nil).joins("left join meta_data md on md.metabolized_id = #{klass.table_name}.#{klass.primary_key} and md.metabolized_type = '#{klass.to_s}' and md.key = '#{k}'")
        }
    end
  end
end
