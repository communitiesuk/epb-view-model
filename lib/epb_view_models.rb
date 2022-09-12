# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module EpbViewModels
  VERSION = "1.0.23"
end

# Monkey patching to avoid using ActiveRecord::Type::Boolean.new.cast
# Source: http://jeffgardner.org/2011/08/04/rails-string-to-boolean-method/
class String
  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || blank? || self =~ (/(false|f|no|n|0)$/i)

    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end
end
