require_relative '../string_calculator'

RSpec.describe "StringCalculator" do
  describe "#add" do
    it "returns 0 for an empty string" do
      expect(add("")).to eq(0)
    end

    it "returns the number itself for a single number" do
      expect(add("1")).to eq(1)
    end

    it "returns the sum of two numbers" do
      expect(add("1,5")).to eq(6)
    end

    it "handles new lines between numbers" do
      expect(add("1\n2,3")).to eq(6)
    end
    
    it "supports different delimiters" do
      expect(add("//;\n1;2")).to eq(3)
    end
  end
end
