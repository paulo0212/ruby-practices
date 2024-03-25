# frozen_string_literal: true

def main(pathnames, lines: true, words: true, chars: true)
  options = return_true_if_params_equal(lines, words, chars)
  count_data = pathnames.count.zero? ? wc_stdin(**options) : wc_files(pathnames, **options)
  count_data.map { |d| format_row(**d) }.join("\n")
end

def return_true_if_params_equal(lines, words, chars)
  all_params_equal = lines == words && words == chars
  return { lines: true, words: true, chars: true } if all_params_equal

  { lines:, words:, chars: }
end

def wc_stdin(lines:, words:, chars:)
  [build_wc_data($stdin.read, label: nil, lines:, words:, chars:)]
end

def build_wc_data(contents, label:, lines:, words:, chars:)
  if contents
    lines_cnt = lines ? contents.lines.count : nil
    words_cnt = words ? contents.split(/\s+/).count : nil
    chars_cnt = chars ? contents.bytesize : nil
  end
  { label:, lines_cnt:, words_cnt:, chars_cnt: }
end

def wc_files(pathnames, lines:, words:, chars:)
  count_data = pathnames.map { |p| wc_file(p, lines:, words:, chars:) }
  count_data << build_total_data(count_data, lines:, words:, chars:) if pathnames.count > 1
  count_data
end

def wc_file(pathname, lines:, words:, chars:)
  file = read_file(pathname)
  build_wc_data(file[:contents], label: file[:label], lines:, words:, chars:)
end

def read_file(pathname)
  return { label: "wc: #{pathname}: open: No such file or directory" } unless pathname.exist?
  return { label: "wc: #{pathname}: read: Is a directory" } if pathname.directory?

  { contents: File.open(pathname, &:read), label: pathname }
end

def build_total_data(data, lines:, words:, chars:)
  lines_cnt = data.sum { |d| d[:lines_cnt].to_i } if lines
  words_cnt = data.sum { |d| d[:words_cnt].to_i } if words
  chars_cnt = data.sum { |d| d[:chars_cnt].to_i } if chars
  { label: 'total', lines_cnt:, words_cnt:, chars_cnt: }
end

def format_row(label:, lines_cnt:, words_cnt:, chars_cnt:)
  counts = [lines_cnt, words_cnt, chars_cnt]
  counts_str = counts.map { |cnt| cnt ? cnt.to_s.rjust(8, ' ') : '' }
  counts_exist = counts.any?(Integer)
  label = " #{label}" if counts_exist && label
  [*counts_str, label].join
end
