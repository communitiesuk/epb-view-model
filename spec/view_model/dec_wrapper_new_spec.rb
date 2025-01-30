require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::DecWrapper do
  context "when calling the DEC wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method" do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-8.0.0", type: "dec-large-building", method_called: :to_hash },
        { schema: "CEPC-NI-8.0.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "dec", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "dec", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "dec", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "dec-ni", method_called: :to_hash },
        { schema: "CEPC-3.1", type: "dec", method_called: :to_hash },
        { schema: "CEPC-3.1", type: "dec-ni", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end
