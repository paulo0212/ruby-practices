#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/game'

score_marks = ARGV[0]
game = Game.new(score_marks)
puts game.score
