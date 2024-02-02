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

      game << frame
      frame = []
    end
    game << frame
  end

  def calculate_total_score(scores_by_frame:)
    total_score = 0
    frames = scores_by_frame

    frames.size.times do |i|
      total_score += frames[i].sum
      next unless frames[i].sum == 10

      next_two_frames = frames.slice(i + 1, 2).flatten
      next if next_two_frames.empty?

      total_score += next_two_frames[0]
      total_score += next_two_frames[1] if frames[i][0] == 10
    end
    total_score
  end
end

scores_str = ARGV[0]
calurator = BowlingScoreCalculator.new(scores_str)
calurator.print_total_score
