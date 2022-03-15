use strict;
use warnings;
use feature qw/say/;
use Acme::Koemu;

my $koemu = Acme::Koemu->new();
say '愛しているよ' if $koemu->love('megumi');

