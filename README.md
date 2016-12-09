# NAME

Test::Vars - Detects unused variables in perl modules

# VERSION

This document describes Test::Vars version 0.012.

# SYNOPSIS

    use Test::Vars;

    # Check all libs that are listed in the MANIFEST file
    all_vars_ok();

    # Check an arbitrary file
    vars_ok('t/lib/MyLib.pm');

    # Ignore some variables while checking
    vars_ok 't/lib/MyLib2.pm', ignore_vars => [ '$an_unused_var' ];

# DESCRIPTION

Test::Vars provides test functions to report unused variables either in an entire distribution or in some files of your choice in order to keep the source code tidy.

# INTERFACE

## Exported

### all\_vars\_ok(%args)

Tests libraries in your distribution with _%args_.

_libraries_ are collected from the `MANIFEST` file.

If you want to ignore variables, for example `$foo`, you can
tell it to the test routines:

- `ignore_vars => { '$foo' => 1 }`
- `ignore_vars => [qw($foo)]`
- `ignore_if => sub{ $_ eq '$foo' }`

Note that `$self` will be ignored by default unless you pass
explicitly `{ '$self' => 0 }` to `ignore_vars`.

### vars\_ok($lib, %args)

Tests _$lib_ with _%args_.

See `all_vars_ok`.

## test\_vars($lib, $result\_handler, %args)

This subroutine tests variables, but instead of outputting TAP, calls the
`$result_handler` subroutine reference provided with the results of the test.

The `$result_handler` sub will be called once, with the following arguments:

- $filename

    The file that was checked for unused variables.

- $exit\_code

    The value of `$?` from the child process that actually did the tests. This
    will be 0 if the tests passed.

- $results

    This is an array reference which in turn contains zero or more array
    references. Each of those references contains two elements, a [Test::Builder](https://metacpan.org/pod/Test::Builder)
    method, either `diag` or `note`, and a message.

    If the method is `diag`, the message contains an actual error. If the method
    is `notes`, the message contains extra information about the test, but is not
    indicative of an error.

# MECHANISM

`Test::Vars` is similar to a part of `Test::Perl::Critic`,but the mechanism
is different.

While `Perl::Critic`, the backend of `Test::Perl::Critic`, scans the source
code as texts, this modules scans the compiled opcode (or AST: abstract syntax
tree) using the `B` module. See also `B` and its submodules.

# CONFIGURATION

`TEST_VERBOSE = 1 | 2 ` shows the way this module works.

# CAVEATS

https://rt.cpan.org/Ticket/Display.html?id=60018

https://rt.cpan.org/Ticket/Display.html?id=82411

# DEPENDENCIES

Perl 5.10.0 or later.

# BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

# SEE ALSO

[Perl::Critic](https://metacpan.org/pod/Perl::Critic)

[warnings::unused](https://metacpan.org/pod/warnings::unused)

[B](https://metacpan.org/pod/B)

[Test::Builder::Module](https://metacpan.org/pod/Test::Builder::Module)

# AUTHOR

Goro Fuji (gfx) &lt;gfuji(at)cpan.org>

# LICENSE AND COPYRIGHT

Copyright (c) 2010, Goro Fuji (gfx). All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. See [perlartistic](https://metacpan.org/pod/perlartistic) for details.
