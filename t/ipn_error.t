#!perl

use strict;
use warnings;

use Test::More tests => 4;
use URI::Escape;

use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

@ARGV = ( 'txn_type=express_checkout' );

$ENV{'CGI_APP_RETURN_ONLY'} = 1;

my $webapp = TestWebapp->new(
    callback => \&check_error,
);
my $output = $webapp->run;

like $output, qr/^ok\z/ms, 'Output';

sub check_error {
    my $cgiapp = shift;
    my $ipn    = $cgiapp->ipn;
    my $error  = $cgiapp->ipn_error;

    is $ipn, undef, 'IPN is undefined';
    like $error, qr/^Insufficient content from the invoker:$/ms,
        'Insufficient content from the invoker';
}
