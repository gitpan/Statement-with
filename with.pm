# $Id: with.pm_rev 1.3 2004/01/07 17:09:03 root Exp root $

# --- --- --- --- --- --- --- --- --- --- ---
#
# SECTION: pod
#

=head1 NAME

Statement::with - implementation of OO 'with' statement

=head1 DESCRIPTION

Implementation of equivalent of javascript's B<with> statement.

Exploits 'AUTOLOAD' mechanism.

=head1 EXPORT

by default:

 (hardwired without any checks)

 sub   AUTOLOAD {...}
 sub   with ($&) {...}
 array @AUTOLOAD_WITH

=head1 SYNTAX

 'with' < blessed object > ',' 'sub' < perl code block > ';'

=head1 SYNOPSIS

 my $obj = MY::PKG->new();
 
 # following two constructs are equivalent
 
 # -1-
 $obj->hello( $word );
 
 # -2-
 with $obj, sub
 {
 	hello( $word );
 }
 
=head1 BUGS

Be carefull about nesting and recursive calls - not tested yet.

=head1 AUTHOR

 mailto:Daniel.Peder@Infoset.COM
 http://www.Infoset.COM/?from=MAN//Statement::with
 
 all
  comments, improvements, bug reports, etc...
 honored

=head1 COPYRIGHT

opensource, free for use, same license as the perl itself.

=head1 SEE ALSO

B<t-with.pl> script in the distro's root dir.

=cut

# --- --- --- --- --- --- --- --- --- --- ---
#
# SECTION: perl code
#

package Statement::with;

	$Statement::with::VERSION  = '1.0';
	$Statement::with::REVISION = (qw$Revision: 1.3 $)[1];

sub import
{
	my( $module ) = caller();
	

	# -- export the 'AUTOLOAD' --
	#
	# AUTOLOAD tries to use the '$sub'
	# as method of '$object' object.
	#
	*{$module.'::AUTOLOAD'} = sub
	{
		my $object   = $AUTOLOAD_WITH[-1];             # get the object refence
		( my $method = $AUTOLOAD ) =~ s{\w+::}{}gos;   # drop the package name prefix
		$object->$method( @_ );                        # call it
	};
	
	# -- export the 'with' --
	#
	*{$module.'::with'} = sub
	{
		my( $object, $code )=@_; 
		push @AUTOLOAD_WITH, $object;            # make the object available to AUTOLOAD
		&$code;                                  # call the 'code block'
		pop @AUTOLOAD_WITH;                      # drop the object
	};

	# -- export the empty '@AUTOLOAD_WITH' --
	#
	*{$module.'::AUTOLOAD_WITH'} = [];
}

1;


__END__

