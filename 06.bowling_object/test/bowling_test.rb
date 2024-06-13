# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class BowlingTest < Minitest::Test
  def test_score1
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game.score
  end

  def test_score2
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, game.score
  end

  def test_score3
    game = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game.score
  end

  def test_score4
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 134, game.score
  end

  def test_score5
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    assert_equal 144, game.score
  end

  def test_score6
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game.score
  end

  def test_score7
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,2')
    assert_equal 292, game.score
  end

  def test_score8
    game = Game.new('X,0,0,X,0,0,X,0,0,X,0,0,X,0,0')
    assert_equal 50, game.score
  end

  def test_score9
    game = Game.new('5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5')
    assert_equal 150, game.score
  end

  def test_score10
    game = Game.new('1,2,3,4,5,5,6,1,9,1,X,X,X,0,0,X,X,0')
    assert_equal 133, game.score
  end

  def test_score11
    game = Game.new('X,0,10,X,0,10,X,0,10,5,5,6,2,X,X,0,10')
    assert_equal 179, game.score
  end
end
