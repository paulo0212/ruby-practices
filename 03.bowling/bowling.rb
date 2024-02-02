#!/usr/bin/env ruby
# frozen_string_literal: true

class BowlingScoreCalculator
  def initialize(scores_str)
    @scores_str = scores_str
  end

  def print_total_score
    scores_by_bowl = split_scores_by_bowl(scores_str: @scores_str)
    scores_by_frame = group_scores_by_frame(scores_by_bowl:)
    puts calculate_total_score(scores_by_frame:)
  end

  private

  def split_scores_by_bowl(scores_str:)
    scores_str.gsub('X', '10').split(',').map(&:to_i)
  end

  def group_scores_by_frame(scores_by_bowl:)
    frame = []
    game = []

    scores_by_bowl.each do |score|
      frame << score
      next unless score == 10 || frame.size == 2
      next if game.size == 9

      frame << 0 if score == 10
      game << frame
      frame = []
    end
    game << frame
  end

  def calculate_total_score(scores_by_frame:)
    total_score = 0

    scores_by_frame.each_cons(2) do |scores|
      total_score += scores[0].sum
      next unless scores[0].sum == 10

      total_score += scores[1][0]
      total_score += scores[1][1] if scores[0][0] == 10
    end
    total_score += scores_by_frame.last.sum
  end
end

SCORES_STR = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
calurator = BowlingScoreCalculator.new(SCORES_STR)
calurator.print_total_score
