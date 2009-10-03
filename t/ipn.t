#!perl

use strict;
use warnings;

use Test::More tests => 42;
use URI::Escape;

use FindBin;
use lib $FindBin::Bin;

BEGIN {
    use_ok 'TestWebapp';
}

# This sample data is taken from PayPal's "IPN Guide."
my %data = (
    'mc_gross'               => '19.95',
    'protection_eligibility' => 'Eligible',
    'address_status'         => 'confirmed',
    'payer_id'               => 'LPLWNMTBWMFAY',
    'tax'                    => '0.00',
    'address_street'         => '1 Main St',
    'payment_date'           => '20:12:59 Jan 13, 2009 PST',
    'payment_status'         => 'Completed',
    'charset'                => 'windows-1252',
    'address_zip'            => '95131',
    'first_name'             => 'Test',
    'mc_fee'                 => '0.88',
    'address_country_code'   => 'US',
    'address_name'           => 'Test User',
    'notify_version'         => '2.6',
    'custom'                 => '',
    'payer_status'           => 'verified',
    'address_country'        => 'United States',
    'address_city'           => 'San Jose',
    'quantity'               => '1',
    'verify_sign' =>
        'AtkOfCXbDm2hu0ZELryHFjY-Vb7PAUvS6nMXgysbElEn9v-1XcmSoGtf',
    'payer_email'         => 'gpmac_1231902590_per@paypal.com',
    'txn_id'              => '61E67681CH3238416',
    'payment_type'        => 'instant',
    'last_name'           => 'User',
    'address_state'       => 'CA',
    'receiver_email'      => 'gpmac_1231902686_biz@paypal.com',
    'payment_fee'         => '0.88',
    'receiver_id'         => 'S8XGHLYDW9T3S',
    'txn_type'            => 'express_checkout',
    'item_name'           => '',
    'mc_currency'         => 'USD',
    'item_number'         => '',
    'residence_country'   => 'US',
    'test_ipn'            => '1',
    'handling_amount'     => '0.00',
    'transaction_subject' => '',
    'payment_gross'       => '19.95',
    'shipping'            => '0.00',
);

# The CGI module will build its query from the command line.
@ARGV = map { join '=', $_, uri_escape( $data{$_} ) } keys %data;

$ENV{'CGI_APP_RETURN_ONLY'} = 1;

my $webapp = TestWebapp->new(
    callback => \&check_ipn,
);

my $output = $webapp->run;

like $output, qr/^ok\z/ms, 'Output';

sub check_ipn {
    my $cgiapp = shift;
    my $ipn    = $cgiapp->ipn;

    isa_ok $ipn, 'Business::PayPal::IPN';

    while ( my ( $k, $v ) = each %data ) {
        is $ipn->$k, $v, "$k = $v";
    }
}
