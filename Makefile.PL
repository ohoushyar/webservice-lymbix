use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Lymbix::API',
    AUTHOR              => q{Omid Houshyar <ohoushyar@gmail.com>},
    VERSION_FROM        => 'lib/Lymbix/API.pm',
    ABSTRACT_FROM       => 'lib/Lymbix/API.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Carp' => 0,
        'Encode' => 0,
        'Mouse' => 0,
        'LWP::UserAgent' => 6,
        'HTTP::Request' => 6,
        'Test::Most' => 0.25,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Lymbix-API-*' },
);
