module RysManagement
  class PluginDelegator < SimpleDelegator

    def name
      l("#{rys_id}.plugin_name")
    end

    def description
      l("#{rys_id}.plugin_description", default: '')
    end

    def feature_records
      RysFeatureRecord.where(name: features.map(&:full_key))
    end

    def feature_records_count
      feature_records.count
    end

    def features
      features = []
      Rys::Feature.all_features.each do |_, feature|
        if feature.plugins.include?(__getobj__)
          features << feature
        end
      end
      features
    end

    def features_count
      features.size
    end

    def edit_partial_path
      "rys_management/plugins/#{rys_id}"
    end

    private

      def l(*args)
        I18n.translate(*args)
      end

  end
end
