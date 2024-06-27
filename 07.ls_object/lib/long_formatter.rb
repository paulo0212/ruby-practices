# frozen_string_literal: true

require_relative './base_formatter'

class LongFormatter < BaseFormatter
  MODE_TABLE = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def format_entries(entries, reverse: false)
    entries = reverse ? entries.reverse : entries

    entry_rows = entries.map { |entry| build_entry_data(entry) }
    block_total = entry_rows.sum { |row| row[:blocks] }
    total = "total #{block_total}"
    body = build_entries_data(entry_rows)

    [total, body]
  end

  private

  def build_entry_data(entry)
    {
      filemode: format_type_and_mode(entry),
      nlink: entry.nlink.to_s,
      owner: entry.owner,
      group: entry.group,
      size: entry.size.to_s,
      mtime: entry.mtime.strftime('%b %e %H:%M'),
      basename: entry.name,
      blocks: entry.blocks
    }
  end

  def format_type_and_mode(entry)
    type = entry.directory? ? 'd' : '-'
    digits = entry.mode.to_s(8)[-3..]
    mode = digits.gsub(/./, MODE_TABLE)
    "#{type}#{mode}"
  end

  def build_entries_data(entries)
    max_sizes = %i[nlink owner group size].map do |key|
      find_max_size(entries, key)
    end
    entries.map do |entry|
      format_row(entry, *max_sizes)
    end
  end

  def find_max_size(entries, key)
    entries.map { |entry| entry[key].length }.max
  end

  def format_row(entry, max_nlink, max_owner, max_group, max_size)
    [
      "#{entry[:filemode]}  ",
      "#{entry[:nlink].rjust(max_nlink)} ",
      "#{entry[:owner].ljust(max_owner)}  ",
      "#{entry[:group].ljust(max_group)}  ",
      "#{entry[:size].rjust(max_size)} ",
      "#{entry[:mtime]} ",
      entry[:basename]
    ].join
  end
end
