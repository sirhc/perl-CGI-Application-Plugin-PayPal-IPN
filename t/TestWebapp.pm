package TestWebapp;
use base 'CGI::Application';

use strict;
use CGI::Application::Plugin::PayPal::IPN;

sub do_first : IPN(first) {
    return 'first';
}

sub do_second : IPN(second,third) {
    return 'second or third';
}

sub do_default : IPN {
    return 'fourth';
}

1;
