package TestWebapp;
use base 'CGI::Application';

use strict;
use CGI::Application::Plugin::PayPal::IPN;

# Prevent Business::PayPal::IPN from validating the transaction with PayPal.
{
    no warnings 'redefine';

    sub Business::PayPal::IPN::_validate_txn {
        return 1;
    }
}

sub do_first : IPN(first) {
    return 'first';
}

sub do_second : IPN(second,third) {
    return 'second or third';
}

sub do_default : IPN {
    return 'fourth';
}

sub express_checkout : IPN(express_checkout) {
    my ( $self ) = @_;

    return $self->check_ipn;
}

sub handle_error : IPN(error) {
    my ( $self ) = @_;

    return $self->ipn_error;
}

1;
