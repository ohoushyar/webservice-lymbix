#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lymbix::API' ) || print "Bail out!\n";
}

diag( "Testing Lymbix::API $Lymbix::API::VERSION, Perl $], $^X" );
