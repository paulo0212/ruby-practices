#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  target_dir = Dir.pwd
  pattern = ['*']
  files = Dir.glob(pattern, base: target_dir)
  ordered_files = files.sort
  list_files(ordered_files)
end

def list_files(files, cols: 3)
  rows = files.size.ceildiv(cols)

  rows.times do |row_num|
    cols.times do |col_num|
      num = row_num + col_num * rows
      break if num >= files.size

      print files[num].ljust(20)
    end
    print "\n"
  end
end

main
