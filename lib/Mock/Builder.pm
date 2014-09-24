package Mock::Builder;
use Moo;
use Carp;
use Types::Standard qw/HashRef CodeRef Str/;

our $VERSION = '0.1';

has class => (
    is => 'rw',
    isa => Str,
    required => 1
);

has subs => (
    is => 'ro',
    isa => HashRef[CodeRef],
    required => 1,
    default => sub { {} }
);

has parent => (
    is => 'rw',
    isa => Str,
    required => 0,
    predicate => 1
);

sub add {
    my $self = shift;
    my $name = shift;
    my $code = shift;

    croak 'Second parameter not a code ref' unless ref $code eq 'CODE';
    $self->subs->{$name} = $code;

    return $self;
}

sub build {
    my $self = shift;
    my $c = $self->class;

    my $eval = sprintf 'package %s; use Moo; ', $c;
    $eval .= sprintf('extends "%s"', $self->parent) if $self->parent;
    eval $eval;

    while(my ($name, $sub) = each %{ $self->subs }) {
        my $abs = $c . '::' . $name;
        {
            no strict 'refs';
            *{$abs} = $sub;
        }
    }

    return $self->class->new;
}


1;
