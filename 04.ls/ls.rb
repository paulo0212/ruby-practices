#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main(options)
  target_dir = Dir.pwd
  pattern = options[:a] ? ['*', File::FNM_DOTMATCH] : ['*']
  files = Dir.glob(*pattern, base: target_dir, sort: true)
  list_files(files)
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

def transform_into_matrix(files, cols)
  matrix = files.each_slice(cols).to_a
  matrix.last.push('') while matrix.last.size < cols
  matrix
end

def measure_longest_file_name(files)
  files.map { |file| file.max_by(&:length).length }
end

def parsed_options
  options = {}
  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.parse!(ARGV)
  options
end

main(parsed_options)
