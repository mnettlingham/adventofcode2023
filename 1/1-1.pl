#!/usr/bin/env perl

use Modern::Perl;

my $file = $ARGV[0].".txt";

open (my $f, "<", $file) or die ("Can't open $file - $!");
my $tot = 0;
while (my $line = <$f>) {
    my($first, $last);
    while ($line =~ /(\d)/g) {
        $first //= $1;
        $last = $1;
    }
    my $num = $first.$last + 0;
    $tot += $num;
}
close($f);
print "Got the answer $tot\n";