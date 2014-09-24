#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

require_ok('Mock::Builder');

{ package XXX; sub test {'abc'} }

my $mb = Mock::Builder->new(class => 'Foo::Bar', parent => 'XXX');

isa_ok($mb, 'Mock::Builder');
is($mb->class, 'Foo::Bar', 'correct class');
is($mb->parent, 'XXX', 'correct parents');

isa_ok($mb->add(test => sub {123}), 'Mock::Builder', 'method chaining');
ok(exists $mb->subs->{test}, 'test exists');
is($mb->subs->{test}->(), 123, 'test has correct return value');

my $fb = $mb->build;
isa_ok($fb, 'Foo::Bar');
ok($fb->isa('XXX'), 'extends XXX');
is($fb->test, 123, 'test returns 123');

done_testing();
