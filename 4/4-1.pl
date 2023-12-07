#!/usr/bin/env perl

use lib qw(.);
use Modern::Perl;
use Data::Dumper;

my $expect = {
    example => {
        winners => 5,
        played => 8,
    },
    input => {
        winners => 10,
        played => 25,
    },
    isawan => {
        winners => 10,
        played => 25,
    }
};

my $file = $ARGV[0];
my $filename = $file.".txt";

my $total;

open (my $f, "<", $filename) or die ("Can't open $filename - $!");
foreach my $line (<$f>) {
    chomp($f);
    if ($line =~ /Card +(\d+): +([\d ]+) \| +([\d ]+)/) {
        my $card_num = $1;
        my @winners = split / +/, $2;
        die("wrong number of winners on line $card_num - got ".scalar @winners) unless @winners == $expect->{$file}->{winners};
        my %winner_map = map {$_ => 1} @winners;
        my $sorted_winners = join(" ", sort {$a <=> $b} keys %winner_map);
        my @played = split / +/, $3;
        die("wrong number of played on line $card_num") unless @played == $expect->{$file}->{played};
        my $sorted_played = join(" ", sort {$a <=> $b} @played);
        my @matches = grep {$winner_map{$_}} @played;
        my $sorted_matches = join(" ", sort {$a <=> $b} @matches);
        my $points = @matches ? 2 ** (@matches-1) : 0;
        $total += $points;
    }
}
close ($f);

print "total $total\n";