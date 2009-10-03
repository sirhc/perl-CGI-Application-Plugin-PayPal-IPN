package CGI::Application::Plugin::PayPal::IPN;
use base 'Exporter';

use strict;
use version; our $VERSION = qv('0.0.1');

use Business::PayPal::IPN;

our @EXPORT = qw( ipn ipn_error ipn_gateway ipn_api_version ipn_version );

sub ipn {
    my ( $self ) = @_;

    if ( !exists $self->{ '' . __PACKAGE__ }{'_ipn'} ) {
        _do_ipn($self);
    }

    return $self->{ '' . __PACKAGE__ }{'_ipn'};
}

sub ipn_error {
    my ( $self ) = @_;

    if ( !exists $self->{ '' . __PACKAGE__ }{'_ipn_error'} ) {
        _do_ipn($self);
    }

    return $self->{ '' . __PACKAGE__ }{'_ipn_error'};
}

sub ipn_gateway {
    my ( $self, $value ) = @_;

    if ( @_ == 2 ) {
        $Business::PayPal::IPN::GTW = $value;
    }

    return $Business::PayPal::IPN::GTW;
}

sub ipn_api_version {
    my ( $self, $value ) = @_;

    return $Business::PayPal::IPN::SUPPORTEDV;
}

sub ipn_version {
    my ( $self, $value ) = @_;

    return $Business::PayPal::IPN::VERSION;
}

sub _do_ipn {
    my ( $cgiapp ) = @_;

    $cgiapp->{ '' . __PACKAGE__ }{'_ipn'}       = undef;
    $cgiapp->{ '' . __PACKAGE__ }{'_ipn_error'} = undef;

    my $query    = $cgiapp->query;
    my $txn_type = $query->param( 'txn_type' );

    return if !defined $txn_type || length $txn_type == 0;

    my $ipn = Business::PayPal::IPN->new( query => $query );

    if ( defined $ipn ) {
        $cgiapp->{ '' . __PACKAGE__ }{'_ipn'} = $ipn;
    }
    else {
        $cgiapp->{ '' . __PACKAGE__ }{'_ipn_error'}
            = Business::PayPal::IPN->error;
    }
}

1;

__END__

=head1 NAME

CGI::Application::Plugin::PayPal::IPN - PayPal IPN support for
CGI::Application

=head1 VERSION

This document describes CGI::Application::Plugin::PayPal::IPN version 0.0.1

=head1 SYNOPSIS

    use My::WebApp::IPN;

    my $webapp = My::WebApp::IPN->new;
    $webapp->run;

    ###

    package My::WebApp::IPN;
    use base 'CGI::Application';

    use CGI::Application::Plugin::PayPal::IPN;

    sub start {
        my $self = shift;
        my $ipn  = $self->ipn;

        # ...
    }

=head1 DESCRIPTION

=head1 INTERFACE 

=over

=item C<< $cgiapp->ipn() >>

=item C<< $cgiapp->ipn_error() >>

=item C<< $cgiapp->ipn_gateway() >>

=item C<< $cgiapp->ipn_api_version() >>

=item C<< $cgiapp->ipn_version() >>

=back

=head1 CONFIGURATION AND ENVIRONMENT

CGI::Application::Plugin::PayPal::IPN requires no configuration files or
environment variables.

=head1 DEPENDENCIES

=over

=item *

L<Business::PayPal::IPN>

=back

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-cgi-application-plugin-paypal-ipn@rt.cpan.org>, or through the web
interface at L<http://rt.cpan.org>.

=head1 AUTHOR

Chris Grau C<< <cgrau@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2009, Chris Grau C<< <cgrau@cpan.org> >>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=head1 SEE ALSO

L<CGI::Application>,
L<Business::PayPal::IPN>
