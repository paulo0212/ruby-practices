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

def main(options)
  Dir.chdir(options[:dir]) if options[:dir]
  files = get_files(options)
  options[:l] ? list_files_in_long_format(files) : list_files(files)
end

def get_files(options)
  pattern = ['*']
  target_dir = Dir.pwd
  # -a オプション
  flags = options[:a] ? File::FNM_DOTMATCH : 0
  files = Dir.glob(pattern, flags, base: target_dir, sort: true)
  # -r オプション
  files.reverse! if options[:r]
  files
end

def list_files(files, cols: 3)
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

    row = []
    row << convert_to_alphabet_filemode(fs.mode.to_s(8).rjust(6, '0'))
    row << fs.nlink.to_s
    row << Etc.getpwuid(fs.uid).name.to_s
    row << Etc.getgrgid(fs.gid).name.to_s
    row << fs.size.to_s
    row << fs.mtime.month.to_s
    row << fs.mtime.day.to_s
    row << fs.mtime.strftime('%R')
    row << file
  end
end

def convert_to_alphabet_filemode(filemode)
  alphabet = FILE_TYPE[filemode.slice(0, 2).to_sym]
  3.step(5) { |n| alphabet += FILE_MODE[filemode.slice(n).to_sym] }
  alphabet
end

def parsed_options
  options = {}
  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  opt.on('-l') { |v| options[:l] = v }
  opt.parse!(ARGV)
  options[:dir] = ARGV.first
  options
end

main(parsed_options)
