# frozen_string_literal: true

require 'shellwords'

def main(pathnames, lines: true, words: true, chars: true)
  options = manage_options(lines, words, chars)
  count_data = pathnames.map { |p| build_wc_data(p, **options) }
  count_data << build_total_data(count_data) if pathnames.count > 1
  count_data.map { |d| format_row(**d) }.join("\n")
end

def manage_options(lines, words, chars)
  all_params_equal = lines == words && words == chars
  return { lines: true, words: true, chars: true } if all_params_equal

  { lines:, words:, chars: }
end

def build_wc_data(pathname, lines: true, words: true, chars: true)
  # TODO: 異常系も実装する
  # 指定パスが存在しない場合 -> `open: No such file or directory`
  # 指定パスがディレクトリの場合 -> `read: Is a directory`
  file = File.open(pathname, &:read)
  lines = lines ? file.lines.count : nil
  words = words ? file.split(/\s+/).count : nil
  chars = chars ? file.bytesize : nil
  { label: pathname, counts: { lines:, words:, chars: }.compact }
end

def build_total_data(data)
  lines = data.sum { |d| d[:counts][:lines] } if data.first[:counts].key?(:lines)
  words = data.sum { |d| d[:counts][:words] } if data.first[:counts].key?(:words)
  chars = data.sum { |d| d[:counts][:chars] } if data.first[:counts].key?(:chars)
  { label: 'total', counts: { lines:, words:, chars: }.compact }
end

def format_row(label:, counts:)
  lines = format_count(counts[:lines])
  words = format_count(counts[:words])
  chars = format_count(counts[:chars])
  [lines, words, chars, " #{label}"].join
end

def format_count(count)
  count ? count.to_s.rjust(8, ' ') : ''
end
