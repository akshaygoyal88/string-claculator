require_relative '../string_calculator'

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 for empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end
    
    it "returns the sum of numbers in a comma-separated string" do
      expect(StringCalculator.add("1,2,3")).to eq(6)
    end
    
    it "returns the sum of numbers with new lines and commas" do
      expect(StringCalculator.add("1\n2,3\n4")).to eq(10)
    end
    
    it "handles custom delimiters" do
      expect(StringCalculator.add("//;\n1;2;3")).to eq(6)
    end

    it "raises an exception for negative numbers" do
      expect { StringCalculator.add("-1,2,-3") }.to raise_error("negatives not allowed: -1, -3")
    end

    it "ignores numbers larger than 1000" do
      expect(StringCalculator.add("2,1001,6")).to eq(8)
    end

    it "handles a mix of scenarios" do
      expect(StringCalculator.add("1\n2,3\n1001,4")).to eq(10)
    end

    it "supports multiple delimiters with different lengths" do
      expect(StringCalculator.add("//[abc][def]\n1abc2def3")).to eq(6)
    end

    it "supports multiple delimiters with different characters" do
      expect(StringCalculator.add("//[x][y][z]\n1x2y3z4")).to eq(10)
    end
    
  end
end
