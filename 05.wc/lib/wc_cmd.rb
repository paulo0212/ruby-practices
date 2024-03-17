# frozen_string_literal: true

require 'shellwords'

def main(pathnames)
  count_data = pathnames.map { |p| build_wc_data(p) }
  count_rows = count_data.map { |d| format_row(**d) }
  if pathnames.size > 1
    total_data = build_total_data(count_data)
    total_row = format_row(**total_data)
  end
  [count_rows, total_row].join("\n")
end

def build_wc_data(pathname)
  # TODO: 異常系も実装する
  # 指定パスが存在しない場合 -> `open: No such file or directory`
  # 指定パスがディレクトリの場合 -> `read: Is a directory`
  file = File.open(pathname, &:read)
  lines = file.lines.count
  words = file.split(/\s+/).count
  chars = file.bytesize
  { label: pathname, counts: { lines:, words:, chars: } }
end

def format_row(label:, counts:)
  lines = counts[:lines].to_s.rjust(8, ' ') || ''
  words = counts[:words].to_s.rjust(8, ' ') || ''
  chars = counts[:chars].to_s.rjust(8, ' ') || ''
  [lines, words, chars, " #{label}"].join
end

def build_total_data(data)
  lines = data.sum { |d| d[:counts][:lines] }
  words = data.sum { |d| d[:counts][:words] }
  chars = data.sum { |d| d[:counts][:chars] }
  { label: 'total', counts: { lines:, words:, chars: } }
end
