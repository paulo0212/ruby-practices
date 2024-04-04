#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'pathname'
require './lib/wc_cmd'

opt = OptionParser.new

options = { lines: false, words: false, chars: false }
opt.on('-l') { |v| options[:lines] = v }
opt.on('-w') { |v| options[:words] = v }
opt.on('-c') { |v| options[:chars] = v }
opt.parse!(ARGV)
pathnames = ARGV.map { |path| Pathname(path) }

puts main(pathnames, **options)
