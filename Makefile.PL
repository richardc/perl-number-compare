use ExtUtils::MakeMaker 6.64;
WriteMakefile(
    NAME         => 'Number::Compare',
    VERSION_FROM => 'lib/Number/Compare.pm',

    PREREQ_PM => {
       'Carp' => 0,
       'strict' => 0,
       'warnings' => 0,
    },

    TEST_REQUIRES => {
       'Test::More' => 0,
    },

    CONFIGURE_REQUIRES => {
        "ExtUtils::MakeMaker" => 6.64,
    },

    LICENSE => 'perl',

    MIN_PERL_VERSION => 5.006,

    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository  => {
                type => 'git',
                web  => 'https://github.com/richardc/perl-number-compare',
                url  => 'https://github.com/richardc/perl-number-compare.git',
            },
        },
    },

);
