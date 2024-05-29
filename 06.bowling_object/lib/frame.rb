# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(shots)
    @shots = shots
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    @shots.first.score == 10
  end

  def spare?
    score == 10 && @shots.count == 2
  end
end
