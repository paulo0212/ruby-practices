# frozen_string_literal: true

class Entry
  def initialize(path)
    @pathname = Pathname.new(path)
  end
end
