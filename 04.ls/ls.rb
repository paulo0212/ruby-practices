#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

FILE_TYPE = {
  '01': 'p',
  '02': 'c',
  '04': 'd',
  '06': 'b',
  '10': '-',
  '12': 'l',
  '14': 's'
}.freeze

FILE_MODE = {
  '0': '---',
  '1': '--x',
  '2': '-w-',
  '3': '-wx',
  '4': 'r--',
  '5': 'r-x',
  '6': 'rw-',
  '7': 'rwx'
}.freeze

SPECIAL_MODE_BIT = {
  '1': { position: 9, char: 't' },
  '2': { position: 6, char: 's' },
  '4': { position: 3, char: 's' }
}.freeze

def main
  options = ARGV.getopts('arl')
  target_dir = ARGV.first
  files = get_files(options, dir: target_dir)
  list_files(files, options)
end

def list_files(files, options)
  # -r オプション
  files = files.reverse if options['r']
  # -l オプション
  options['l'] ? list_files_in_long_format(files) : list_files_in_default_format(files)
end

def get_files(options, dir: Dir.pwd, pattern: '*')
  # -a オプション
  flags = options['a'] ? File::FNM_DOTMATCH : 0
  Dir.glob(pattern, flags, base: dir, sort: true)
end

def list_files_in_default_format(files, cols: 3)
  rows = files.size.ceildiv(cols)
  files_matrix = transform_into_matrix(files, rows)
  col_width = measure_longest_file_name(files_matrix)

  files_matrix.transpose.each do |files_row|
    files_row.each_with_index do |file, i|
      print file&.ljust(col_width[i] + 2)
    end
    print "\n"
  end
end

def list_files_in_long_format(files)
  file_stats = get_file_stats(files)
  col_width = measure_longest_file_name(file_stats.transpose)
  total = files.sum { |file| File.lstat(file).blocks }

  puts "total #{total}"
  file_stats.each do |file_stat|
    file_stat.each_with_index do |fs, i|
      print i == file_stat.size - 1 ? fs : fs.rjust(col_width[i])
      print '  '
    end
    print "\n"
  end
end

def transform_into_matrix(files, cols)
  matrix = files.each_slice(cols).to_a
  matrix.last.push('') while matrix.last.size < cols
  matrix
end

def measure_longest_file_name(files)
  files.map { |file| file.max_by(&:length).length }
end

def get_file_stats(files)
  files.map do |file|
    file_path = "#{Dir.pwd}/#{file}"
    fs = File::Stat.new(file_path)
    [
      get_alphabet_filemode(fs),
      fs.nlink.to_s,
      Etc.getpwuid(fs.uid).name.to_s,
      Etc.getgrgid(fs.gid).name.to_s,
      fs.size.to_s,
      fs.mtime.strftime('%-m %_d %R'),
      file
    ]
  end
end

def get_alphabet_filemode(file_stat)
  octal_number = file_stat.mode.to_s(8).rjust(6, '0')
  # 1-2文字目はファイルタイプ
  alphabet = FILE_TYPE[octal_number.slice(0, 2).to_sym]
  # 4-6文字目はファイルモード
  alphabet += (3..5).map { FILE_MODE[octal_number[_1].to_sym] }.join
  replace_special_mode_bit(octal_number, alphabet)
  alphabet
end

def replace_special_mode_bit(octal_number, alphabet)
  special_mode_bit_number = octal_number.slice(2)
  return if special_mode_bit_number == '0'

  special_mode_bit = SPECIAL_MODE_BIT[number.to_sym]
  alphabet[special_mode_bit[:position]] = special_mode_bit[:char]
end

main
