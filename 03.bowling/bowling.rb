#!/usr/bin/env ruby
# frozen_string_literal: true

class BowlingScore
  def initialize(scores_str)
    @scores_str = scores_str
  end

  def print_total_score
    scores_by_bowl = split_scores_by_bowl(@scores_str)
    scores_by_frame = group_scores_by_frame(scores_by_bowl)
    puts calculate_total_score(scores_by_frame)
  end

  private

  def split_scores_by_bowl(scores_str)
    scores_str.gsub('X', '10').split(',').map(&:to_i)
  end

  def group_scores_by_frame(scores_by_bowl)
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
    game
  end

  def calculate_total_score(scores_by_frame)
    total_score = 0

    scores_by_frame.each_with_index do |frame, i|
      total_score += frame.sum
      next unless frame.sum == 10

      next_two_frames = scores_by_frame.slice(i + 1, 2).flatten
      next if next_two_frames.empty?

      total_score += next_two_frames[0]
      total_score += next_two_frames[1] if frame[0] == 10
    end
    total_score
  end
end

scores_str = ARGV[0]
bowling_score = BowlingScore.new(scores_str)
bowling_score.print_total_score
