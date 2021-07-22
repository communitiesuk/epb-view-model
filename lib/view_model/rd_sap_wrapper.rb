module ViewModel
  class RdSapWrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type, additional_data = {})
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::RdSap::Summary.new(view_model)
      @report = Presenter::RdSap::Report.new(view_model, schema_type, additional_data)
      @recommendation_report = Presenter::RdSap::RecommendationReport.new(view_model)
    end

    def type
      :RdSAP
    end

    def to_hash
      @summary.to_hash
    end

    def to_report
      @report.to_hash
    end

    def to_recommendation_report
      @recommendation_report.to_hash
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"RdSAP-Schema-20.0.0"
        ViewModel::RdSapSchema200::CommonSchema.new xml_doc
      when :"RdSAP-Schema-19.0"
        ViewModel::RdSapSchema190::CommonSchema.new xml_doc
      when :"RdSAP-Schema-18.0"
        ViewModel::RdSapSchema180::CommonSchema.new xml_doc
      when :"RdSAP-Schema-17.1"
        ViewModel::RdSapSchema171::CommonSchema.new xml_doc
      when :"RdSAP-Schema-17.0"
        ViewModel::RdSapSchema170::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-20.0.0"
        ViewModel::RdSapSchemaNi200::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-19.0"
        ViewModel::RdSapSchemaNi190::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-18.0"
        ViewModel::RdSapSchemaNi180::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-17.4"
        ViewModel::RdSapSchemaNi174::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-17.3"
        ViewModel::RdSapSchemaNi173::CommonSchema.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
