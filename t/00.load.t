#!perl -T

use strict;
use warnings;
use Test::More tests => 1;

BEGIN {
    use_ok 'CGI::Application::Plugin::PayPal::IPN';
}

diag "Testing CGI::Application::Plugin::PayPal::IPN $CGI::Application::Plugin::PayPal::IPN::VERSION";
diag "Perl $]";
diag $^X;
