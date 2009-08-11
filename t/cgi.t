#!perl

use strict;
use warnings;
use Test::More tests => 5;
use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

for my $test ( qw( first second third fourth ) ) {
    run_test($test);
}

sub run_test {
    my ($test) = @_;

    # The extra key/value pairs are to keep Business::PayPal::IPN happy, which
    # assumes any query with less than three keys is an error.
    @ARGV = ( "txn_type=$test", map "$_=$_", qw( a b c ) );

    # Force the CGI module to re-read @ARGV.
    {
        no warnings 'once';
        undef @CGI::QUERY_PARAM;
    }

    close STDOUT;
    open STDOUT, '>', \my $stdout or die "Can't open STDOUT: $!";

    my $webapp = TestWebapp->new;
    $webapp->run;

    # We only care about the last line of output.  Above that are just HTTP
    # headers.
    my $last = ( split /\n/, $stdout )[-1];

    like $last, qr/\b$test\b/, $test;
}
