#!/usr/bin/env perl

use Modern::Perl;

my %map = (
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9,
    eno => 1,
    owt => 2,
    eerht => 3,
    ruof => 4,
    evif => 5,
    xis => 6,
    neves => 7,
    thgie => 8,
    enin => 9,
);

my $file = $ARGV[0].".txt";

open (my $f, "<", $file) or die ("Can't open $file - $!");
my $tot = 0;
my($first, $last);
while (my $line = <$f>) {
    chomp($line);
    if ($line =~ /(\d|one|two|three|four|five|six|seven|eight|nine)/g) {
        $first = exists $map{$1} ? $map{$1} : $1;
    }
    else {
        die("No first number in $line\n");
    }
    my $reverse_line = join("", reverse split //, $line);
    if ($reverse_line =~ /(\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)/g) {
        $last = exists $map{$1} ? $map{$1} : $1;
    }
    else {
        die("No last number in $reverse_line\n");
    }
    my $num = $first.$last + 0;
    $tot += $num;
}
close($f);
print "Got the answer $tot\n";