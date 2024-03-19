# frozen_string_literal: true

def main(pathnames, lines: true, words: true, chars: true)
  options = manage_options(lines, words, chars)
  count_data = pathnames.count.zero? ? wc_stdin(**options) : wc_files(pathnames, **options)
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
  count_data = pathnames.map { |p| wc_file(p, lines:, words:, chars:) }
  count_data << build_total_data(count_data, lines:, words:, chars:) if pathnames.count > 1
  count_data
end

def wc_file(pathname, lines: true, words: true, chars: true)
  file = read_file(pathname)
  build_wc_data(file[:contents], label: file[:label], lines:, words:, chars:)
end

def read_file(pathname)
  return { label: "wc: #{pathname}: open: No such file or directory" } unless pathname.exist?
  return { label: "wc: #{pathname}: read: Is a directory" } if pathname.directory?

  { contents: File.open(pathname, &:read), label: pathname }
end

def build_wc_data(contents, label: nil, lines: true, words: true, chars: true)
  if contents
    lines_cnt = lines ? contents.lines.count : nil
    words_cnt = words ? contents.split(/\s+/).count : nil
    chars_cnt = chars ? contents.bytesize : nil
  end
  { label:, counts: { lines: lines_cnt, words: words_cnt, chars: chars_cnt }.compact }
end

def build_total_data(data, lines: true, words: true, chars: true)
  lines = data.sum { |d| d[:counts][:lines].to_i } if lines
  words = data.sum { |d| d[:counts][:words].to_i } if words
  chars = data.sum { |d| d[:counts][:chars].to_i } if chars
  { label: 'total', counts: { lines:, words:, chars: }.compact }
end

def format_row(label:, counts:)
  lines = format_count(counts[:lines])
  words = format_count(counts[:words])
  chars = format_count(counts[:chars])
  label = counts.none? || label.nil? ? label : " #{label}"
  [lines, words, chars, label].join
end

def format_count(count)
  count ? count.to_s.rjust(8, ' ') : ''
end
