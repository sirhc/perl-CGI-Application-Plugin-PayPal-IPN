use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'CGI::Application::Plugin::PayPal::IPN',
    license           => 'perl',
    dist_author       => 'Chris Grau <cgrau@cpan.org>',
    dist_version_from => 'lib/CGI/Application/Plugin/PayPal/IPN.pm',
    build_requires    => {
        'Test::More' => 0,
    },
    requires          => {
        'Business::PayPal::IPN' => 0,
        'CGI::Application'      => '4.00',
        'version'               => 0,
    },
    add_to_cleanup    => [ 'CGI-Application-Plugin-PayPal-IPN-*' ],
);

$builder->create_build_script;
