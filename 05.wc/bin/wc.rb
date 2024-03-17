#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require './lib/wc_cmd'

pathnames = ARGV.map { |path| Pathname(path) }

puts main(pathnames)
