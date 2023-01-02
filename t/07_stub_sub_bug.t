#!perl -w

use strict;
use Test::More;

unless ( eval "require Moose::Role; 1;" ) {
    plan skip_all => 'This test requires Moose::Role';
}

use File::Spec::Functions qw( catfile );
use Test::Vars;

# A Moose role that declares a stub sub for an attribute accessor _before_
# declaring the attribute triggers an odd bug in Test::Vars.
SKIP: {
	skip 'Unreliable test', 2;
    my $file = catfile( qw( t lib StubSub.pm ) );
    my @unused;
    my $handler = sub {
        push @unused, [@_];
    };

    local $@;
    eval { test_vars( $file, $handler ) };
    is( $@, q{}, 'no exception calling test_vars on t/lib/StubSub.pm' );
    is_deeply(
        \@unused,
        [
            [
                't/lib/StubSub.pm',
                256,
                [
                    [
                        'note',
                        'checking StubSub in StubSub.pm ...'
                    ],
                    [
                        'diag',
                        /\$x\s+is\s+used\s+once/
                    ]
                ]
            ]
        ],
        'got expected output from test_vars'
    );
}

done_testing;
