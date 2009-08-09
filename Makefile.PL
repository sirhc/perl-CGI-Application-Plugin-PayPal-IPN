use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'CGI::Application::Plugin::PayPal::IPN',
    AUTHOR        => 'Chris Grau <cgrau@cpan.org>',
    VERSION_FROM  => 'lib/CGI/Application/Plugin/PayPal/IPN.pm',
    ABSTRACT_FROM => 'lib/CGI/Application/Plugin/PayPal/IPN.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'CGI-Application-Plugin-PayPal-IPN-*' },
);
