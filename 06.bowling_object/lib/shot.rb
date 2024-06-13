# frozen_string_literal: true

class Shot
  MAX_SCORE = 10

  def initialize(score_mark)
    @score_mark = score_mark
  end

  def score
    @score_mark == 'X' ? MAX_SCORE : @score_mark.to_i
  end
end
