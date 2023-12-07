package Number;

use Moo;

has id => (is => 'ro', required => 1);
has number => (is => 'ro', required => 1);
has seen => (is => 'rw', default => 0);

1;