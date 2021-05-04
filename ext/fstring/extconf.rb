require 'mkmf'

if Symbol.method_defined?(:name)
  File.write("Makefile", dummy_makefile($srcdir).join(""))
else
  $CFLAGS << " -D_GNU_SOURCE -Werror -Wall "
  if ENV.key?('DEBUG')
    $CFLAGS << " -O0 -g -DDEBUG "
  else
    $CFLAGS << " -O3 "
  end

  create_makefile('fstring/fstring')
end
