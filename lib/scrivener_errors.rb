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
  }.freeze

  def initialize(scrivener)
    @scrivener = scrivener
    ensure_validated
  end

  def ensure_validated
    if scrivener.errors == {}
      scrivener.valid?
    end
  end

  def to_s
    messages.join(', ').capitalize
  end
  alias :message :to_s

  def messages
    scrivener.errors.inject([]) do |memo, error|
      att = error[0]
      memo.concat error[1].map {|e| error_string(att, e) }
      memo
    end
  end

  def error_string(att, error)
    att = att.to_s.tr('_', ' ')
    failure   = MESSAGES.fetch(error, 'is invalid')

    [att, failure].join(' ')
  end

  module Helpers
    def filter_error(scrivener)
      ScrivenerErrors.new(scrivener).to_s
    end
  end
end
