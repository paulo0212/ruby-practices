# frozen_string_literal: true

class Shot
  def initialize(score_mark)
    @score_mark = score_mark
  end

  def score
    @score_mark == 'X' ? 10 : @score_mark.to_i
  end
end
