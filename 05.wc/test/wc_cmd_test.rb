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

  def setup
    @pathname = [Pathname('./test/fixtures/01_fizzbuzz.rb')]
    @pathnames = TARGET_PATHS.map { |p| Pathname(p) }.freeze
  end

  # ファイル指定 && オプションなし
  def test_main_with_1_file
    expected = `wc ./test/fixtures/01_fizzbuzz.rb`.chomp
    assert_equal expected, main(@pathname)
  end

  def test_main_with_4_files
    expected = `wc #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected, main(@pathnames)
  end

  # ファイル指定 && オプションあり
  def test_main_with_l_option
    expected_count = `wc -l ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -l #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: true, words: false, chars: false)
    assert_equal expected_total, main(@pathnames, lines: true, words: false, chars: false)
  end

  def test_main_with_w_option
    expected_count = `wc -w ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -w #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: false, words: true, chars: false)
    assert_equal expected_total, main(@pathnames, lines: false, words: true, chars: false)
  end

  def test_main_with_c_option
    expected_count = `wc -c ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -c #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: false, words: false, chars: true)
    assert_equal expected_total, main(@pathnames, lines: false, words: false, chars: true)
  end

  def test_main_with_lw_options
    expected_count = `wc -lw ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -lw #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: true, words: true, chars: false)
    assert_equal expected_total, main(@pathnames, lines: true, words: true, chars: false)
  end

  def test_main_with_wc_options
    expected_count = `wc -wc ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -wc #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: false, words: true, chars: true)
    assert_equal expected_total, main(@pathnames, lines: false, words: true, chars: true)
  end

  def test_main_with_lc_options
    expected_count = `wc -lc ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -lc #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: true, words: false, chars: true)
    assert_equal expected_total, main(@pathnames, lines: true, words: false, chars: true)
  end

  def test_main_with_lwc_options
    expected_count = `wc -lwc ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -lwc #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: true, words: true, chars: true)
    assert_equal expected_total, main(@pathnames, lines: true, words: true, chars: true)
  end

  def test_main_with_cwl_options
    expected_count = `wc -cwl ./test/fixtures/01_fizzbuzz.rb`.chomp
    expected_total = `wc -cwl #{TARGET_PATHS.join(' ')}`.chomp
    assert_equal expected_count, main(@pathname, lines: true, words: true, chars: true)
    assert_equal expected_total, main(@pathnames, lines: true, words: true, chars: true)
  end

  # 標準入力
  def test_main_with_stdin
    expected_count = `ls ./test/fixtures | wc`.chomp
    $stdin = StringIO.new(`ls ./test/fixtures`)
    assert_equal expected_count, main([], lines: true, words: true, chars: true)
  end
end
