#include "ruby.h"

void Init_fstring()
{
    rb_define_method(rb_cSymbol, "name", rb_sym2str, 0);
}
