#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  target_dir = Dir.pwd
  pattern = ['*']
  files = Dir.glob(pattern, base: target_dir)
  ordered_files = files.sort
  list_files(ordered_files)
end

def list_files(files)
  files.each { |file| print file, ' ' }
  print "\n"
end

main
