# frozen_string_literal: true

require 'shellwords'

def main(pathnames, lines: true, words: true, chars: true)
  options = manage_options(lines, words, chars)
  count_data = pathnames.count.zero? ? wc_stdin(**options) : wc_files(pathnames, **options)
  count_data << build_total_data(count_data) if pathnames.count > 1
  count_data.map { |d| format_row(**d) }.join("\n")
end

def manage_options(lines, words, chars)
  all_params_equal = lines == words && words == chars
  return { lines: true, words: true, chars: true } if all_params_equal

  { lines:, words:, chars: }
end

def wc_stdin(lines: true, words: true, chars: true)
  [build_wc_data($stdin.read, lines:, words:, chars:)]
end

def wc_files(pathnames, lines: true, words: true, chars: true)
  pathnames.map do |pathname|
    # TODO: 異常系も実装する
    # 指定パスが存在しない場合 -> `open: No such file or directory`
    # 指定パスがディレクトリの場合 -> `read: Is a directory`
    file = File.open(pathname, &:read)
    build_wc_data(file, label: pathname, lines:, words:, chars:)
  end
end

def build_wc_data(contents, label: nil, lines: true, words: true, chars: true)
  lines = lines ? contents.lines.count : nil
  words = words ? contents.split(/\s+/).count : nil
  chars = chars ? contents.bytesize : nil
  { label:, counts: { lines:, words:, chars: }.compact }
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
  label = " #{label}" if label
  [lines, words, chars, label].join
end

def format_count(count)
  count ? count.to_s.rjust(8, ' ') : ''
end
