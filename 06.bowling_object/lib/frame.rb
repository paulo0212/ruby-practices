# frozen_string_literal: true

require_relative 'shot'

class Frame
  MAX_SHOTS = 2
  MAX_SCORE = Shot::MAX_SCORE

  def initialize(score_marks)
    @shots = score_marks.map { |sm| Shot.new(sm) }
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    @shots.first.score == MAX_SCORE
  end

  def spare?
    @shots.size == MAX_SHOTS && score == MAX_SCORE
  end
end
