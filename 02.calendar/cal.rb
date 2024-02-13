#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

class Calendar
  DAY_OF_WEEK = 'Su Mo Tu We Th Fr Sa'
  PRINT_WIDTH = DAY_OF_WEEK.length

  def initialize(year, month)
    year = year&.to_i || Date.today.year
    month = month&.to_i || Date.today.month
    @target_date = Date.new(year, month, 1)
  end

  def print_calendar
    print_header
    print_body
  end

  private

  def print_header
    puts @target_date.strftime('%B %Y').center(PRINT_WIDTH)
    puts DAY_OF_WEEK
  end

  def print_body
    last_date = Date.new(@target_date.year, @target_date.month, -1)

    print '   ' * @target_date.wday
    @target_date.step(last_date) do |date|
      print format_day(date)
      print date.saturday? ? "\n" : ' '
    end
    print "\n"
  end

  def format_day(date)
    day_str = date.day.to_s.rjust(2, ' ')
    date == Date.today ? "\e[7m#{day_str}\e[0m" : day_str
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
