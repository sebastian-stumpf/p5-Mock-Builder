#!/usr/bin/env perl
use strict;
use warnings;
use feature qw/say/;
use Mock::Builder;

my $mb = Mock::Builder->new(class => 'Foo');

my $foo = $mb->add(bar => sub {'bar'})
    ->add(baz => sub {'baz'})
    ->add(quux => sub {'quux'})
    ->build;

say for $foo->bar, $foo->baz, $foo->quux;
