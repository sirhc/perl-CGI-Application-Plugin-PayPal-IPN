#!perl

use strict;
use warnings;
use Test::More;

plan skip_all => 'AUTHOR_TEST is not set' if !$ENV{'AUTHOR_TEST'};

eval 'use Test::Perl::Critic';
plan skip_all => 'Test::Perl::Critic required for testing PBP compliance'
    if $@;

all_critic_ok();
