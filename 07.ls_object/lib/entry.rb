# frozen_string_literal: true

class Entry
  attr_reader :name

  def initialize(path)
    @pathname = Pathname.new(path)
    @name = File.basename(path)
  end
end
