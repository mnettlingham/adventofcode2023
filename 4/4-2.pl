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

my %card_count;
my $card_num;
open (my $f, "<", $filename) or die ("Can't open $filename - $!");
foreach my $line (<$f>) {
    chomp($f);
    if ($line =~ /Card +(\d+): +([\d ]+) \| +([\d ]+)/) {
        $card_num = $1;
        $card_count{$card_num}++;
        my @winners = split / +/, $2;
        die("wrong number of winners on line $card_num - got ".scalar @winners) unless @winners == $expect->{$file}->{winners};
        my %winner_map = map {$_ => 1} @winners;
        #print Dumper \%winner_map;
        my $sorted_winners = join(" ", sort {$a <=> $b} keys %winner_map);
        my @played = split / +/, $3;
        die("wrong number of played on line $card_num") unless @played == $expect->{$file}->{played};
        my @matches = grep {$winner_map{$_}} @played;
        if (@matches) {
            foreach (1..$card_count{$card_num}) {
                for (1..scalar @matches) {
                    my $id = $card_num + $_;
                    $card_count{$id}++;
                }
            }
        }
    }
}
close ($f);

my %filtered_list = map {$_ => $card_count{$_}} grep {$_ <= $card_num} keys %card_count;
my $tot;
$tot += $filtered_list{$_} foreach keys %filtered_list;
print "total $tot\n";