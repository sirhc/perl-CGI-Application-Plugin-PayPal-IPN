#!perl

use strict;
use warnings;

use Test::More tests => 4;

use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

$ENV{'CGI_APP_RETURN_ONLY'} = 1;

my $webapp = TestWebapp->new(
    callback => \&check_version,
);
my $output = $webapp->run;

like $output, qr/^ok\z/ms, 'Output';

sub check_version {
    my $cgiapp = shift;

    is $cgiapp->ipn_version, $Business::PayPal::IPN::VERSION,
        "Module version is $Business::PayPal::IPN::VERSION";

    is $cgiapp->ipn_api_version, $Business::PayPal::IPN::SUPPORTEDV,
        "API version is $Business::PayPal::IPN::SUPPORTEDV";
}
