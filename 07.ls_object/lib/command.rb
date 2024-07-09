# frozen_string_literal: true

require_relative './entry'
require_relative './short_format'
require_relative './long_format'

class Command
  def initialize(base_pathname, all: false, long: false, reverse: false)
    @base_pathname = base_pathname
    @all = all
    @long = long
    @reverse = reverse
  end

  def self.list_entries(...)
    new(...).list_entries
  end

  def list_entries
    entries = collect_entries(@base_pathname, all: @all)
    formatted_entries = format_entries(entries, long: @long, reverse: @reverse)
    puts formatted_entries
  end

  private

  def collect_entries(base_pathname, all: false)
    pattern = base_pathname.join('*')
    params = all ? [pattern, File::FNM_DOTMATCH] : [pattern]
    Dir.glob(*params).map { |path| Entry.new(path) }
  end

  def format_entries(entries, long: false, reverse: false)
    format = long ? LongFormat.new : ShortFormat.new
    format.generate(entries, reverse:)
  end
end
