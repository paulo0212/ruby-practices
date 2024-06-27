#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'pathname'
require_relative '../lib/command'

opt = OptionParser.new

options = { all: false, long: false, reverse: false }
opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:long] = v }
opt.on('-r') { |v| options[:reverse] = v }
opt.parse!(ARGV)

path = ARGV[0] || '.'
pathname = Pathname.new(path)

if !pathname.exist?
  puts "ls: #{pathname}: No such file or directory"
  exit
end

Command.list_entries(pathname, **options)
