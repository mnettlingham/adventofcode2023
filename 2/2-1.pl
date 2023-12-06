#!/usr/bin/env perl

use Modern::Perl;
use Data::Dumper;

my $file = $ARGV[0].".txt";

open (my $f, "<", $file) or die ("Can't open $file - $!");
my $total = 0;
my %results;
while (my $line = <$f>) {
    if ($line =~ /^Game (\d+): (.+)$/) {
        chomp($line);
        my $game_num = $1;
        $results{$game_num}{draws} = $2;
        my @draws = split /; /, $2;
        foreach my $draw (@draws) {
            foreach my $col (qw/red blue green/) {
                $results{$game_num}{$col} //= 0;
                if ($draw =~ /(\d+) $col/) {
                    $results{$game_num}{$col} = $1 if $results{$game_num}{$col} < $1;
                }
            }
        }
        if ($results{$game_num}{red} <= 12 && $results{$game_num}{green} <= 13 && $results{$game_num}{blue} <= 14) {
            $total += $game_num;
        } 
    }
    else {
        die("Cannot parse line $line");
    }
}
close($f);

print "Total $total\n";