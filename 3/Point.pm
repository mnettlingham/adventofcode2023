package Point;

use Modern::Perl;
use Moo;

has x => (is => 'ro', required => 1);
has y => (is => 'ro', required => 1);
has value => (is => 'ro', required => 1);
has adjacent_numbers => (is => 'rw', required => 1, default => sub {{}});

has symbol => (is => 'lazy', builder => sub {
    my($self) = @_;
    return ref($self->value) ne 'Number' && $self->value ne '.';
});

has gear => (is => 'lazy', builder => sub {
    my($self) = @_;
    return $self->value eq '*';
});

1;