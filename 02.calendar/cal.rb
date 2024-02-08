#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

class Calendar
  DAY_OF_WEEK = 'Su Mo Tu We Th Fr Sa'
  PRINT_WIDTH = DAY_OF_WEEK.length

  def initialize(year, month)
    target_year = year&.to_i || Date.today.year
    target_month = month&.to_i || Date.today.month
    @target_date = Date.new(target_year, target_month, 1)
  end

  def print_calendar
    print_headers
    print_numbers
  end

  private

  def print_headers
    puts @target_date.strftime('%B %Y').center(PRINT_WIDTH)
    puts DAY_OF_WEEK
  end

  def print_numbers
    first_day = Date.new(@target_date.year, @target_date.month, 1)
    last_day = Date.new(@target_date.year, @target_date.month, -1)

    print '   ' * first_day.wday
    first_day.step(last_day) do |date|
      print formatted_day(date:)
      puts if date.saturday?
    end
    puts
  end

  def formatted_day(date:)
    day_str = date.day.to_s.rjust(2, ' ')
    day_str = "\e[7m#{day_str}\e[0m " if date == Date.today
    day_str.ljust(3, ' ')
  end
end

def parse_options
  options = {}
  opt = OptionParser.new
  opt.on('-y', '-y [year]', Integer) { |v| options[:y] = v }
  opt.on('-m', '-m [month]', Integer) { |v| options[:m] = v }
  opt.parse!(ARGV)
  options
end

options = parse_options
calendar = Calendar.new(options[:y], options[:m])
calendar.print_calendar
