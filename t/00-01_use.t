use strict;
use warnings;
use Test::Easy;

use Statement::with;

TEST 'module use',
CODE {
 return 1;
}
;

RUN;

exit;
__END__
