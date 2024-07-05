# frozen_string_literal: true

require 'io/console'
require_relative './base_format'

class ShortFormat < BaseFormat
  PADDING = 1

  def initialize
    super
    @win_size = IO.console.winsize[1]
  end

  def generate(entries, reverse: false)
    entries = reverse ? entries.reverse : entries

    @col_size = entries.map { |entry| entry.name.length }.max + PADDING
    cols = @win_size / @col_size
    rows = entries.count.ceildiv(cols)

    transposed_entries = safe_transpose(entries.each_slice(rows).to_a)
    transposed_entries.map do |entries_row|
      format_row(entries_row)
    end
  end

  private

  def safe_transpose(nested_entries)
    nested_entries[0].zip(*nested_entries[1..])
  end

  def format_row(entries)
    entries.map { |entry| format_entry(entry) }.join.rstrip
  end

  def format_entry(entry)
    entry&.name&.ljust(@col_size)
  end
end
