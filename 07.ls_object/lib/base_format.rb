# frozen_string_literal: true

class BaseFormat
  def generate(entries, reverse: false)
    raise NotImplementedError, 'Subclasses must implement `generate` method.'
  end
end
