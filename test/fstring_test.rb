# frozen_string_literal: true

require "test_helper"

class FStringTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FString::VERSION
  end

  def test_Symbol_name_returns_internal_symbol_fstring
    fstring = :foo.name
    assert_equal 'foo', fstring
    assert_equal Encoding::US_ASCII, fstring.encoding
    assert_fstring fstring
  end

  def test_Symbol_name_works_with_dynamic_symbols
    string = "abceslfkdslfkdsfsdlfsfd"
    fstring = string.to_sym.name
    assert_equal string, fstring
    assert_equal Encoding::US_ASCII, fstring.encoding
    assert_fstring fstring
  end

  def test_Symbol_to_s_is_patched
    with_patch do
      fstring = :foo.to_s
      assert_equal 'foo', fstring
      assert_equal Encoding::US_ASCII, fstring.encoding
      assert_fstring fstring
    end
  end

  def test_Symbol_id2name_is_not_patched
    with_patch do
      fstring = :foo.id2name
      assert_equal 'foo', fstring
      assert_equal Encoding::US_ASCII, fstring.encoding
      refute_fstring fstring
    end
  end

  private

  def assert_fstring(string)
    description = JSON.parse(ObjectSpace.dump(string))
    assert description["fstring"], "Expected #{string.inspect} to be interned, but wasn't"
  end

  def refute_fstring(string)
    description = JSON.parse(ObjectSpace.dump(string))
    refute description["fstring"], "Expected #{string.inspect} to not be interned, but it was"
  end

  def with_patch
    FString.patch_symbol!
    yield
  ensure
    FString.unpatch_symbol!
  end
end
