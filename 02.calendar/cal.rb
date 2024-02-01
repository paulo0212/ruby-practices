# frozen_string_literal: true

require 'date'

class Calendar
  DAY_OF_WEEK = 'Su Mo Tu We Th Fr Sa'
  PRINT_WIDTH = DAY_OF_WEEK.length

  attr_reader :target_date

  def initialize(target_date = Date.today)
    @target_date = target_date
  end

  def print_calendar
    print_headers
  end

  private

  def print_headers
    puts target_date.strftime('%B %Y').center(PRINT_WIDTH)
    puts DAY_OF_WEEK
  end
end

calendar = Calendar.new
calendar.print_calendar
