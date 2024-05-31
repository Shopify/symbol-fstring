# frozen_string_literal: true

require "fstring/version"

module FString
  require "fstring/fstring" unless Symbol.method_defined?(:name)

  class << self
    def patch_symbol!
      unless Symbol.method_defined?(:_original_to_s)
        Symbol.alias_method(:_original_to_s, :to_s)
      end
      Symbol.alias_method(:to_s, :to_s)
      Symbol.alias_method(:to_s, :name)
    end

    def unpatch_symbol!
      Symbol.alias_method(:to_s, :_original_to_s)
    end
  end
end
