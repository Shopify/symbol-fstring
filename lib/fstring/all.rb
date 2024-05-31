# frozen_string_literal: true

if Symbol.method_defined?(:name)
  Symbol.alias_method(:to_s, :to_s) # Suppress warning
  Symbol.alias_method(:to_s, :name)
else
  require "fstring"
  FString.patch_symbol!
end
