#!perl -w
use strict;
use Test::More tests => 4;

BEGIN { use_ok("Number::Compare") };

my $gt_20 = Number::Compare->new('>20');
ok(  $gt_20->test(21), ">20" );
ok( !$gt_20->test(20) );
ok( !$gt_20->test(19) );
