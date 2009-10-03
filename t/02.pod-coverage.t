#!perl

use strict;
use warnings;
use Test::More;

plan skip_all => 'AUTHOR_TEST is not set' if !$ENV{'AUTHOR_TEST'};

eval 'use Test::Pod::Coverage 1.04';
plan skip_all => 'Test::Pod::Coverage 1.04 required for testing POD coverage'
    if $@;

all_pod_coverage_ok();
