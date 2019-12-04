# frozen_string_literal: true

require "test_helper"

class FStringTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FString::VERSION
  end

  def test_returns_internal_symbol_fstring
    fstring = FString.symbol_to_s(:foo)
    assert_equal 'foo', fstring
    assert_equal Encoding::US_ASCII, fstring.encoding
    assert_fstring fstring
  end

  def test_works_with_dynamic_symbols
    string = "abceslfkdslfkdsfsdlfsfd"
    fstring = FString.symbol_to_s(string.to_sym)
    assert_equal string, fstring
    assert_equal Encoding::US_ASCII, fstring.encoding
    assert_fstring fstring
  end

  def test_symbol_to_s_is_patched
    with_patch do
      fstring = :foo.to_s
      assert_equal 'foo', fstring
      assert_equal Encoding::US_ASCII, fstring.encoding
      assert_fstring fstring
    end
  end

  private

  def assert_fstring(string)
    description = JSON.parse(ObjectSpace.dump(string))
    assert description["fstring"], "Expected #{string.inspect} to be interned, but wasn't"
  end

  def with_patch
    FString.patch_symbol!
    yield
  ensure
    FString.unpatch_symbol!
  end
end
