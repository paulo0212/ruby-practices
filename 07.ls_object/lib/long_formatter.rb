# frozen_string_literal: true

require_relative './base_formatter'

class LongFormatter < BaseFormatter
  def format_entries(entries, reverse: false)
    target_entries = reverse ? entries.reverse : entries
    puts '= = = = = Long Formatter = = = = ='
    target_entries.map do |e|
      format_entry(e)
    end
  end

  private

  def format_entry(entry)
    "formatted_#{entry.inspect}"
  end
end
