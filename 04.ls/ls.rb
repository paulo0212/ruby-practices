#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  target_dir = Dir.pwd
  pattern = ['*']
  files = Dir.glob(pattern, base: target_dir)
  puts files
end

main
