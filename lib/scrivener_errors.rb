class ScrivenerErrors
  attr_reader :scrivener

  MESSAGES = {
    :not_email    => "is not an email",
    :not_decimal  => "is not a decimal",
    :not_in_range => "has invalid length",
    :not_numeric  => "is not a number",
    :not_present  => "can't be blank",
    :not_url      => "is not a url",
    :too_short    => "is too short"
  }

  def initialize(scrivener)
    @scrivener = scrivener
    ensure_validated
  end

  def ensure_validated
    if scrivener.errors == {}
      scrivener.valid?
    end
  end

  def [](att)
    errors = scrivener.errors[att.to_sym]

    if errors.length > 0
      errors.map { |e| lookup(e) }.join(', ')
    end
  end

  def message
    messages.join(', ').capitalize
  end
  alias :to_s :message

  def messages
    scrivener.errors.each_with_object([]) do |error, collection|
      att = error[0]
      collection.concat error[1].map {|e| error_string(att, e) }
    end
  end

  def error_string(att, error)
    att     = att.to_s.tr('_', ' ')
    [att, lookup(error)].join(' ')
  end

  def lookup(key)
    MESSAGES.fetch(key, 'is invalid')
  end

  module Helpers
    def filter_error(scrivener)
      ScrivenerErrors.new(scrivener).to_s
    end
  end
end
