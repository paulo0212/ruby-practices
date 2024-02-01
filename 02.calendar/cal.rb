# frozen_string_literal: true

require 'date'

class Calendar
  DAY_OF_WEEK = 'Su Mo Tu We Th Fr Sa'
  PRINT_WIDTH = DAY_OF_WEEK.length

  attr_reader :target_date, :first_day, :last_day

  def initialize(target_date = Date.today)
    @target_date = target_date
  end

  def print_calendar
    print_headers
    print_numbers
  end

  private

  def print_headers
    puts target_date.strftime('%B %Y').center(PRINT_WIDTH)
    puts DAY_OF_WEEK
  end

  def print_numbers
    first_day = Date.new(target_date.year, target_date.month, 1)
    last_day = Date.new(target_date.year, target_date.month, -1)

    print '   ' * first_day.wday
    first_day.step(last_day) do |date|
      print date.day.to_s.rjust(2, ' '), ' '
      puts if date.saturday?
    end
    puts
  end
end

calendar = Calendar.new
calendar.print_calendar
