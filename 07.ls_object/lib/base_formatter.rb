# frozen_string_literal: true

class BaseFormatter
  def format(entries, reverse: false)
    raise NotImplementedError, 'Subclasses must implement print_entries.'
  end
end
