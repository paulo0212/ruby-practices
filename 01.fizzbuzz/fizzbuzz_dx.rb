# frozen_string_literal: true

def fizzbuzz(start_num: 1, end_num: 20, fizz: 'Fizz', buzz: 'Buzz', fizz_num: 3, buzz_num: 5)
  puts "\n= = = = = = = = = ="
  puts "#{start_num}から#{end_num}までの整数を出力します。\nただし、#{fizz_num}の倍数のときは「#{fizz}」、#{buzz_num}の倍数のときは「#{buzz}」、#{fizz_num}と#{buzz_num}の公倍数のときは#{fizz}#{buzz}と出力します。"
  puts '= = = = = = = = = ='
  (start_num..end_num).each do |n|
    message = ''
    message += fizz if (n % fizz_num).zero?
    message += buzz if (n % buzz_num).zero?
    message = n if message.empty?
    puts message
  end
end

puts "FizzBuzz-dx\n"
puts "\n{start_num}から{end_num}までの整数を出力します。\nただし、{fizz_num}の倍数のときは「{fizz}」、{buzz_num}の倍数のときは「{buzz}」、{fizz_num}と{buzz_num}の公倍数のときは{fizz}{buzz}と出力します。"
print "\n> start_num: "
start_num = gets.to_i
puts "\n#{start_num}から{end_num}までの整数を出力します。\nただし、{fizz_num}の倍数のときは「{fizz}」、{buzz_num}の倍数のときは「{buzz}」、{fizz_num}と{buzz_num}の公倍数のときは{fizz}{buzz}と出力します。"
print "\n> end_num: "
end_num = gets.to_i
puts "\n#{start_num}から#{end_num}までの整数を出力します。\nただし、{fizz_num}の倍数のときは「{fizz}」、{buzz_num}の倍数のときは「{buzz}」、{fizz_num}と{buzz_num}の公倍数のときは{fizz}{buzz}と出力します。"
print "\n> fizz_num: "
fizz_num = gets.to_i
puts "\n#{start_num}から#{end_num}までの整数を出力します。\nただし、#{fizz_num}の倍数のときは「{fizz}」、{buzz_num}の倍数のときは「{buzz}」、#{fizz_num}と{buzz_num}の公倍数のときは{fizz}{buzz}と出力します。"
print "\n> fizz: "
fizz = gets.chomp
puts "\n#{start_num}から#{end_num}までの整数を出力します。\nただし、#{fizz_num}の倍数のときは「#{fizz}」、{buzz_num}の倍数のときは「{buzz}」、#{fizz_num}と{buzz_num}の公倍数のときは#{fizz}{buzz}と出力します。"
print "\n> buzz_num: "
buzz_num = gets.to_i
puts "\n#{start_num}から#{end_num}までの整数を出力します。\nただし、#{fizz_num}の倍数のときは「#{fizz}」、#{buzz_num}の倍数のときは「{buzz}」、#{fizz_num}と#{buzz_num}の公倍数のときは#{fizz}{buzz}と出力します。"
print "\n> buzz: "
buzz = gets.chomp

fizzbuzz(start_num:, end_num:, fizz:, buzz:, fizz_num:, buzz_num:)
