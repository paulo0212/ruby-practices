# frozen_string_literal: true

class Frame
  MAX_SCORE = 10
  MAX_SHOTS = 2

  attr_accessor :shots

  def initialize(shots = [])
    @shots = shots
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    @shots.first.score == MAX_SCORE
  end

  def spare?
    score == MAX_SCORE && @shots.count == MAX_SHOTS
  end

  def move_to_next?
    strike? || @shots.count >= MAX_SHOTS
  end
end
