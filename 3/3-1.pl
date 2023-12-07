#!/usr/bin/env perl

use lib qw(.);
use Modern::Perl;
use Data::Dumper;
use Point;
use Number;

my $file = $ARGV[0].".txt";

open (my $f, "<", $file) or die ("Can't open $file - $!");
my @points;
my $x = 1;
my $max_y;
foreach my $line (<$f>) {
    chomp($line);
    my @nums;
    while ($line =~ /(\d+)/g) {
        push @nums, Number->new(number => $1);
    }
    my $num_idx = 0;
    my $on_num = 0;
    my $y = 1;
    foreach my $char (split //, $line) {
        print ".";
        if ($char =~ /\d/) {
            $on_num =  1;
            push @points, Point->new(x => $x, y => $y++, value => $nums[$num_idx]);
        }
        else {
            $num_idx++ if $on_num;
            $on_num = 0;
            push @points, Point->new(x => $x, y => $y++, value => $char);
        }
    }
    $max_y = $y;
    $x++;
    print "\n";
}
close ($f);
my $max_x = $x;

my $total;
foreach my $point (grep {$_->symbol} @points) {
    foreach my $row ($point->x-1 .. $point->x + 1) {
      next if $row < 1 or $row > $max_x;
        foreach my $col ($point->y-1 .. $point->y+1) {
            next if $col < 1 or $col > $max_y;
            my($point) = grep {$_->x == $row && $_->y == $col} @points;
            die ("No point at $row, $col") unless $point;
            my $val = $point->value;
            if ($val->isa('Number') && $val->seen eq 0) {
                $total += $val->number;
                $val->seen(1);
            }
        }
    }
}

print "Total is $total\n";