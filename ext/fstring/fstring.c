#include "fstring.h"

VALUE
rb_fstring_symbol_to_s(VALUE rb_mFString, VALUE symbol)
{
    return rb_sym2str(symbol);
}

void Init_fstring()
{
    VALUE rb_mFString;

    rb_mFString = rb_const_get(rb_cObject, rb_intern("FString"));
    rb_define_singleton_method(rb_mFString, "symbol_to_s", rb_fstring_symbol_to_s, 1);
}
