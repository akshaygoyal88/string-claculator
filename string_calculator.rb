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
    numbers.split(/#{delimiters_regex}|\n/)
  end
end

puts StringCalculator.add("")                  # Output: 0
puts StringCalculator.add("1")                 # Output: 1
puts StringCalculator.add("1,2")               # Output: 3
puts StringCalculator.add("1\n2,3")            # Output: 6
puts StringCalculator.add("//;\n1;2")          # Output: 3 (delimiter is ';')
puts StringCalculator.add("//***\n1***2***3")  # Output: 6 (delimiter is '***')
puts StringCalculator.add("//[*][%]\n1*2%3")   # Output: 6 (delimiters are '*' and '%')
puts StringCalculator.add("2,1001,6")          # Output: 8 (1001 is ignored)
puts StringCalculator.add("//[***][%]\n1***2%3") # Output: 6 (delimiters are '***' and '%')
begin
  puts StringCalculator.add("-1,2,-3")         # Exception: negatives not allowed: -1, -3
rescue => e
  puts "Exception: #{e.message}"
end
