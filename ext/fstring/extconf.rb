require 'mkmf'

$CFLAGS = "-D_GNU_SOURCE -Werror -Wall "
if ENV.key?('DEBUG')
  $CFLAGS << "-O0 -g -DDEBUG"
else
  $CFLAGS << "-O3"
end

create_makefile('fstring/fstring')
