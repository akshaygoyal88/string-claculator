def add(numbers)
    return 0 if numbers.empty?
    
    delimiter = ","
    if numbers.start_with?("//")
      delimiter = numbers[2]
      numbers = numbers[4..-1]
    end
    
    numbers.split(/[,\n#{delimiter}]/).map(&:to_i).sum
end

puts "Enter numbers separated by commas or newlines:"
input = gets.chomp
result = add(input)
puts "Sum: #{result}"