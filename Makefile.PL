use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(

	# depend => { Makefile => '$(VERSION_FROM)' },

    'NAME'           => 'Statement::with',
    'VERSION_FROM'   => 'with.pm', # finds $VERSION
    'PREREQ_PM'      => 
	                    { # e.g., Module::Name => 1.1
							strict        => 0,
						},
    ($] >= 5.005 ? (
      ABSTRACT_FROM  => 'with.pm', 
      AUTHOR         => 'Daniel Peder <Daniel.Peder@Infoset.COM>',
    ) : ()),
);
sub MY::postamble { q{

docs : README

README: with.pm
	pod2text --loose with.pm > README

xdist:
	[ -f MANIFEST ] && rm -f MANIFEST ; make realclean docs manifest tardist; perl Makefile.PL

}; }
