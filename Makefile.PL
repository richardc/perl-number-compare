use ExtUtils::MakeMaker;

my $module = 'Compare.pm';
WriteMakefile(NAME         => 'Number::Compare',
              VERSION_FROM => $module,
              PREREQ_PM => { 'Test::More'     => 0 });

sub MY::postamble {
    return <<EOF
README: $module
\tpod2text $module > README
EOF
}
