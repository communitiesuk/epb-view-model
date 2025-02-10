require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::AcReportWrapper do
  context "when calling the AC-REPORT wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-NI-8.0.0", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "ac-report", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "ac-report", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end
