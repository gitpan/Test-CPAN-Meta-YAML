#!/usr/bin/perl -w
use strict;

use Test::More;

# Skip if doing a regular install
plan skip_all => "Author tests not required for installation"
    unless ( $ENV{AUTOMATED_TESTING} );

eval "use Test::CPAN::Meta::YAML";
plan skip_all => "Test::CPAN::Meta::YAML required for testing META.yml" if $@;

plan 'no_plan';

my $meta = meta_spec_ok(undef,undef,@_);

use Test::CPAN::Meta::YAML;
my $version = $Test::CPAN::Meta::YAML::VERSION;

is($meta->{version},$version,
    'META.yml distribution version matches');

if($meta->{provides}) {
    for my $mod (keys %{$meta->{provides}}) {
        is($meta->{provides}{$mod}{version},$version,
            "META.yml entry [$mod] version matches");
    }
}
