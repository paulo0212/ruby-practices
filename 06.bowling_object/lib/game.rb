# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  MAX_FRAMES = 10

  def initialize(score_marks)
    shots = parse_score_marks(score_marks)
    @frames = build_frames(shots)
  end

  def score
    @frames.map.with_index do |frame, idx|
      frame_score = frame.score
      frame_score += bonus_score(@frames, idx) if frame != @frames.last
      frame_score
    end.sum
  end

  private

  def parse_score_marks(score_marks)
    score_marks.split(',').map { |sm| Shot.new(sm) }
  end

  def build_frames(shots)
    frames = []
    current_frame = Frame.new()

    shots.each do |shot|
      current_frame.shots << shot
      next if frames.size + 1 == MAX_FRAMES

      if current_frame.move_to_next?
        frames << current_frame # 1st to 9th frame
        current_frame = Frame.new()
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
