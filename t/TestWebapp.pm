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

sub new {
    my ( $class, %param ) = @_;

    my $self = $class->SUPER::new;

    $self->{'TestWebapp'} = \%param;

    return $self;
}

sub setup {
    my $self = shift;

    $self->run_modes( 'start' => 'start' );
}

sub start {
    my $self     = shift;
    my $ipn      = $self->ipn;
    my $callback = $self->{'TestWebapp'}{'callback'};

    if ( ref $callback eq 'CODE' ) {
        $callback->($self);
    }

    return 'ok';
}

1;
