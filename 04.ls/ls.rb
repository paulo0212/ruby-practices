#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  target_dir = Dir.pwd
  pattern = ['*']
  files = Dir.glob(pattern, base: target_dir, sort: true)
  list_files(files)
end

def list_files(files, cols: 3)
  rows = files.size.ceildiv(cols)
  files_matrix = transform_into_matrix(files, rows)
  col_width = measure_longest_file_name(files_matrix)

  files_matrix.transpose.each do |files|
    files.each_with_index do |file, i|
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

main
