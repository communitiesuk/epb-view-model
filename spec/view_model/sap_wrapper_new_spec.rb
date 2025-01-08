require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::SapWrapper do
  context "when calling the sap wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method" do
      schema_tests = [
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-12.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-11.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-11.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-15.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-13.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-12.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-11.2", type: "sap", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end
