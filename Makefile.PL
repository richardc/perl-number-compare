use ExtUtils::MakeMaker;
my $module = 'lib/Number/Compare.pm';
%depends = ( 'Test::More' => 0 );
WriteMakefile(NAME         => 'Number::Compare',
              VERSION_FROM => $module,
              PREREQ_PM => \%depends)
  if $0 =~ m/makefile.pl/i;

sub MY::postamble {
    return <<EOF
README: $module Changes Makefile.PL ../makereadme
\t../makereadme $module \$(NAME) \$(VERSION) > README

dist: README

cover:
\trm -rf cover_db
\tPERL5OPT=-MDevel::Cover \$(MAKE) test || true
\tcover cover_db
EOF
}

1;
