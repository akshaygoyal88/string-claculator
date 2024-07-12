def add(numbers)
    return 0 if numbers.empty?
    numbers.split(/[,\n]/).map(&:to_i).sum
end

puts "Enter numbers separated by commas or newlines:"
input = gets.chomp
result = add(input)
puts "Sum: #{result}"