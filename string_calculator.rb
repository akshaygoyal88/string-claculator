class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiter = find_delimiters(numbers)
    numbers_without_delimiter = remove_delimiter_declaration(numbers)

    nums = split_numbers(numbers_without_delimiter, delimiter).map(&:to_i)

    negatives = nums.select { |num| num < 0 }
    if negatives.any?
      raise "negatives not allowed: #{negatives.join(', ')}"
    end

    sum = nums.inject(0) do |acc, num|
      num <= 1000 ? acc + num : acc
    end

    sum
  end

  def self.find_delimiters(numbers)
    if numbers.start_with?("//")
      delimiter_line = numbers.lines.first.chomp
      delimiter_line.gsub!("//", "")
      delimiter_line.scan(/\[([^\[\]]+)\]/).flatten
    else
      [","]
    end
  end

  def self.remove_delimiter_declaration(numbers)
    if numbers.start_with?("//")
      numbers.lines.drop(1).join
    else
      numbers
    end
  end

  def self.split_numbers(numbers, delimiters)
    delimiters_regex = delimiters.map { |delim| Regexp.escape(delim) }.join("|")
    parts = numbers.split(/#{delimiters_regex}/)
    
    if parts.any? { |part| part.end_with?("\n") }
      raise "not need to prove it - just clarifying"
    end
    
    parts.reject { |num| num.empty? }
  end
end


# Test cases to verify functionality
puts StringCalculator.add("")                    # Output: 0
puts StringCalculator.add("1")                   # Output: 1
puts StringCalculator.add("1,2")                 # Output: 3
puts StringCalculator.add("1\n2,3")              # Output: 6
puts StringCalculator.add("//;\n1;2")            # Output: 3 
puts StringCalculator.add("//***\n1***2***3")    # Output: 6 
puts StringCalculator.add("//[*][%]\n1*2%3")     # Output: 6 
puts StringCalculator.add("2,1001,6")            # Output: 8 
puts StringCalculator.add("//[***][%]\n1***2%3") # Output: 6 

begin
  puts StringCalculator.add("-1,2,-3")           
rescue => e
  puts "Exception: #{e.message}"
end

begin
  puts StringCalculator.add("1,\n") 
rescue => e
  puts "Exception: #{e.message}"
end