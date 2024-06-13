# frozen_string_literal: true

require_relative 'frame'

class Game
  MAX_FRAMES = 10

  def initialize(score_marks)
    @score_marks = score_marks
    @frames = parse_score_marks.map { |sm| Frame.new(sm) }
  end

  def score
    @frames.map.with_index do |frame, idx|
      frame_score = frame.score
      frame_score += bonus_score(@frames, idx) if frame != @frames.last
      frame_score
    end.sum
  end

  private

  def parse_score_marks
    frames = []
    current_frame = []

    @score_marks.split(',').each do |score_mark|
      current_frame << score_mark
      next if frames.size == MAX_FRAMES - 1

      if score_mark == 'X' || current_frame.size == Frame::MAX_SHOTS
        frames << current_frame.dup # 1st to 9th frame
        current_frame.clear
      end
    end
    frames << current_frame # 10th frame
    frames
  end

  def bonus_score(frames, idx)
    current_frame = frames[idx]

    if current_frame.strike?
      next_two_frames = [frames[idx + 1]&.shots, frames[idx + 2]&.shots].flatten
      next_two_shots = next_two_frames.first(2)
      next_two_shots.sum(&:score)
    elsif current_frame.spare?
      next_shot = frames[idx + 1].shots.first
      next_shot.score
    else
      0
    end
  end
end
