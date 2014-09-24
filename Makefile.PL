use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    ABSTRACT => 'generate mock classes on the fly',
    NAME => 'Mock::Builder',
    VERSION_FROM => 'lib/Mock/Builder.pm',
    AUTHOR => 'Sebastian Stumpf <sepp@perlhacker.org>',
    PREREQ_PM => {
        'Moo' => '0',
        'Type::Tiny' => '0'
    },
    LICENSE => 'perl'
);
