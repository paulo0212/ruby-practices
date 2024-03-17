# frozen_string_literal: true

(1..20).each do |n|
  message = ''
  message += 'Fizz' if (n % 3).zero?
  message += 'Buzz' if (n % 5).zero?
  message = n if message.empty?
  puts message
end
