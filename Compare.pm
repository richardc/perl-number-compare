# $Id$
package Number::Compare;
use strict;
use Carp qw(croak);
use vars qw/$VERSION/;
$VERSION = '0.01';

sub new  {
    my $referent = shift;
    my $class = ref $referent || $referent;
    my $test = shift;

    $test =~ m{^
               ([<>]=?)?   # comparison
               (.*?)       # value
               ([kmg]i?)?  # magnitude
              $}ix
       or croak "don't understand '$test' as a test";

    my $comparison = $1 || '==';
    my $target     = $2;
    my $magnitude  = $3;
    $target *=           1000 if lc $magnitude eq 'k';
    $target *=           1024 if lc $magnitude eq 'ki';
    $target *=        1000000 if lc $magnitude eq 'm';
    $target *=      1024*1024 if lc $magnitude eq 'mi';
    $target *=     1000000000 if lc $magnitude eq 'g';
    $target *= 1024*1024*1024 if lc $magnitude eq 'gi';

    bless { target => $target, comparison => $comparison }, $class;
}

sub test {
    my $self = shift;
    my $value = shift;

    my ($target, $comparison) = @$self{ 'target', 'comparison' };
    return eval "$value $comparison $target";
}

1;
