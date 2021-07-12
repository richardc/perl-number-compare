package Number::Compare;
use strict;
use warnings;
use 5.006;

use Carp qw(croak);

our $VERSION = '0.03';

sub new  {
    my $referent = shift;
    my $class = ref $referent || $referent;
    my $expr = $class->parse_to_perl( shift );

    bless eval "sub { \$_[0] $expr }", $class;
}

sub parse_to_perl {
    shift;
    my $test = shift;

    $test =~ m{^
               ([<>]=?)?     # comparison
               (.*?)         # value
               ([kmgtpe]i?)? # magnitude
              $}ix
       or croak "don't understand '$test' as a test";

    my $comparison = $1 || '==';
    my $target     = $2;
    my $magnitude  = $3 || '';
    $target *=                          1000 if lc $magnitude eq 'k';
    $target *=                          1024 if lc $magnitude eq 'ki';
    $target *=                       1000000 if lc $magnitude eq 'm';
    $target *=                     1024*1024 if lc $magnitude eq 'mi';
    $target *=                    1000000000 if lc $magnitude eq 'g';
    $target *=                1024*1024*1024 if lc $magnitude eq 'gi';
    $target *=                 1000000000000 if lc $magnitude eq 't';
    $target *=           1024*1024*1024*1024 if lc $magnitude eq 'ti';
    $target *=              1000000000000000 if lc $magnitude eq 'p';
    $target *=      1024*1024*1024*1024*1024 if lc $magnitude eq 'pi';
    $target *=           1000000000000000000 if lc $magnitude eq 'e';
    $target *= 1024*1024*1024*1024*1024*1024 if lc $magnitude eq 'ei';

    return "$comparison $target";
}

sub test { $_[0]->( $_[1] ) }

1;

__END__

=head1 NAME

Number::Compare - numeric comparisons

=head1 SYNOPSIS

 Number::Compare->new(">1Ki")->test(1025); # is 1025 > 1024

 my $c = Number::Compare->new(">1M");
 $c->(1_200_000);                          # slightly terser invocation

=head1 DESCRIPTION

Number::Compare compiles a simple comparison to an anonymous
subroutine, which you can call with a value to be tested again.

Now this would be very pointless, if Number::Compare didn't understand
magnitudes.

The target value may use magnitudes of kilobytes (C<k>, C<ki>),
megabytes (C<m>, C<mi>), gigabytes (C<g>, C<gi>), terabytes (C<t>, C<ti>),
petabytes (C<p>, C<pi>), or exabytes (C<e>, C<ei>).
Those suffixed with an C<i> use the appropriate 2**n version in accordance with the
IEC standard: http://physics.nist.gov/cuu/Units/binary.html

=head1 METHODS

=head2 -E<gt>new( $test )

Returns a new object that compares the specified test.

=head2 -E<gt>test( $value )

A longhanded version of $compare-E<gt>( $value ).  Predates blessed
subroutine reference implementation.

=head2 -E<gt>parse_to_perl( $test )

Returns a perl code fragment equivalent to the test.

=head1 AUTHOR

Richard Clamp E<lt>richardc@unixbeard.netE<gt>

=head1 COPYRIGHT

Copyright (C) 2002,2011 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

http://physics.nist.gov/cuu/Units/binary.html

=cut
