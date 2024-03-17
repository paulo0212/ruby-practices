# frozen_string_literal: true

require 'minitest/autorun'
require 'pathname'
require './lib/wc_cmd'

class WcCmdTest < Minitest::Test
  TARGET_PATHS = [
    './test/fixtures/01_fizzbuzz.rb',
    './test/fixtures/02_cal.rb',
    './test/fixtures/03_bowling.rb',
    './test/fixtures/04_ls.rb'
  ].freeze

  def test_main_with_1_file
    expected = `wc ./test/fixtures/01_fizzbuzz.rb`
    pathnames = [Pathname('./test/fixtures/01_fizzbuzz.rb')]
    assert_equal expected, main(pathnames)
  end

  def test_main_with_2_files
    expected = `wc ./test/fixtures/01_fizzbuzz.rb ./test/fixtures/02_cal.rb`.chomp
    pathnames = [Pathname('./test/fixtures/01_fizzbuzz.rb'), Pathname('./test/fixtures/02_cal.rb')]
    assert_equal expected, main(pathnames)
  end

  def test_main_with_4_files
    expected = `wc #{TARGET_PATHS.join(' ')}`.chomp
    pathnames = TARGET_PATHS.map { |p| Pathname(p) }.freeze
    assert_equal expected, main(pathnames)
  end
end
