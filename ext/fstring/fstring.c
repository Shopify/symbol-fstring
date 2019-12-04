#include "fstring.h"

VALUE
rb_symbol_to_fstring(VALUE symbol)
{
    return rb_sym2str(symbol);
}

VALUE
rb_fstring_symbol_to_s(VALUE rb_mFString, VALUE symbol)
{
    return rb_sym2str(symbol);
}

VALUE
rb_fstring_patch_symbol(VALUE rb_mFString)
{
    VALUE rb_cSymbol;
    rb_cSymbol = rb_const_get(rb_cObject, rb_intern("Symbol"));
    rb_undef(rb_cSymbol, rb_intern("to_s"));
    rb_define_method(rb_cSymbol, "to_s", rb_symbol_to_fstring, 0);
    return Qnil;
}

VALUE
rb_fstring_unpatch_symbol(VALUE rb_mFString)
{
    VALUE rb_cSymbol;
    rb_cSymbol = rb_const_get(rb_cObject, rb_intern("Symbol"));
    rb_undef(rb_cSymbol, rb_intern("to_s"));
    rb_define_method(rb_cSymbol, "to_s", rb_sym_to_s, 0);
    return Qnil;
}

void Init_fstring()
{
    VALUE rb_mFString;

    rb_mFString = rb_const_get(rb_cObject, rb_intern("FString"));
    rb_define_singleton_method(rb_mFString, "symbol_to_s", rb_fstring_symbol_to_s, 1);
    rb_define_singleton_method(rb_mFString, "patch_symbol!", rb_fstring_patch_symbol, 0);
    rb_define_singleton_method(rb_mFString, "unpatch_symbol!", rb_fstring_unpatch_symbol, 0);
}
