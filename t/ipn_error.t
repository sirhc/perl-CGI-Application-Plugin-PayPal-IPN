#!perl

use strict;
use warnings;
use Test::More tests => 2;
use URI::Escape;
use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

@ARGV = ( 'txn_type=express_checkout' );

close STDOUT;
open STDOUT, '>', \my $stdout or die "Can't open STDOUT: $!";

my $webapp = TestWebapp->new;
$webapp->run;

like $stdout, qr/^Insufficient content from the invoker:$/ms;
