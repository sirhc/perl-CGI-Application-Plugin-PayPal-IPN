package CGI::Application::Plugin::PayPal::IPN;

use strict;
use version; our $VERSION = qv('0.0.1');

1;

__END__

=head1 NAME

CGI::Application::Plugin::PayPal::IPN - ...

=head1 VERSION

This document describes CGI::Application::Plugin::PayPal::IPN version 0.0.1

=head1 SYNOPSIS

    use My::WebApp::IPN;

    my $webapp = My::WebApp::IPN->new(
        PARAMS => {
            user_agent => ...,
        },
    );
    $webapp->run;

    ###

    package My::WebApp::IPN;
    use base 'CGI::Application';

    use CGI::Application::Plugin::PayPal::IPN;

    __PACKAGE__->ipn->user_agent(...);

    sub handle_completed : IPN(completed) {
        my $self = shift;
        my $ipn  = $self->ipn;

        return 1;
    }

    sub handle_YYY : IPN(YYY) {
        ...

        return 0;
    }

=head1 DESCRIPTION

=head1 INTERFACE 

=head1 DIAGNOSTICS

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

=back

=head1 CONFIGURATION AND ENVIRONMENT

CGI::Application::Plugin::PayPal::IPN requires no configuration files or
environment variables.

=head1 DEPENDENCIES

None.

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

Copyright (c) 2009, Chris Grau C<< <cgrau@cpan.org> >>.
All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.  See L<perlartistic>.

=head1 SEE ALSO

L<CGI::Application>,
L<Business::PayPal::IPN>
