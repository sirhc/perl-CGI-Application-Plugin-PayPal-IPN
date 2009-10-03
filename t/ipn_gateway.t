#!perl

use strict;
use warnings;

use Test::More tests => 5;

use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

$ENV{'CGI_APP_RETURN_ONLY'} = 1;

my $webapp = TestWebapp->new(
    callback => \&check_gateway,
);
my $output = $webapp->run;

like $output, qr/^ok\z/ms, 'Output';

sub check_gateway {
    my $cgiapp = shift;

    is $cgiapp->ipn_gateway, 'https://www.paypal.com/cgi-bin/webscr',
        'Default gateway';

    is $cgiapp->ipn_gateway('foobar'), 'foobar', 'Update gateway';
    is $cgiapp->ipn_gateway, 'foobar', 'Modified gateway';
}
