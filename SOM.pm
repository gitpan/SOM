package SOM;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

@SOMClassPtr::ISA = ('SOMObjectPtr');

require Exporter;
require DynaLoader;

@ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use SOM ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
%EXPORT_TAGS = ( 'types' => [ qw(	
   tk_void
   tk_short
   tk_ushort
   tk_long
   tk_ulong
   tk_float
   tk_double
   tk_char
   tk_boolean
   tk_octet
   tk_enum
   tk_string
   tk_pointer
) ], 'class' => [ qw(
   Find_Class RepositoryNew SOMClassMgr SOMClass SOMObject SOMClassMgrObject
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'class'} }, @{ $EXPORT_TAGS{'types'} } );

@EXPORT = qw(

);
$VERSION = '0.01';

bootstrap SOM $VERSION;

# Preloaded methods go here.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

SOM - Perl extension for blah blah blah

=head1 SYNOPSIS

  use SOM;
  blah blah blah

=head1 DESCRIPTION

Supported types (exported with the tag C<:types>):

   tk_short
   tk_ushort
   tk_long
   tk_ulong
   tk_float
   tk_double
   tk_char
   tk_boolean
   tk_octet
   tk_enum
   tk_string
   tk_pointer
   tk_void		# Output only

Supported services:

  $class = Find_Class($classname, $major, $minor)

Returns SOM Class object.  Use C<$major = $minor = 0> if you do not need
a version check.

  $obj = $class->NewObject()

Creates a new instance of an object of the given class.

  $repo = RepositoryNew()

Creates a Repository object.

  SOMClass()

Returns the SOM (meta)class C<SOMClass>.

  SOMObject()

Returns the SOM class C<SOMObject>.

  SOMClassMgr()

Returns the SOM class C<SOMClassMgr>.

  SOMClassMgrObject()

Returns the standard C<SOMClassMgrObject> object.

  $obj->Dispatch0($method_name)

Dispatches a method with void return and no arguments.

  $obj->Dispatch_templ($method_name, $template, ...)

Dispatches a method with return type and arguments described by a $template.
See F<test.pl> how to build template.

  $obj->GetClass()

Return the class of the object (as a SOM object).

=head2 EXPORT

None by default.  Tags C<:types>, C<:class>.

=head1 AUTHOR

A. U. Thor, a.u.thor@a.galaxy.far.far.away

=head1 BUGS

Calling non-existing SOM method is a fatal error.

Only primitive types of parameters and return value are supported.

Only in-parameters are supported.

No memory management is done at all.

Exception is not analysed.

SOM Objects have type SOMObjectPtr, SOM Classes have type SOMClassPtr.

Methods may be dispatched only when a signature is explicitely described.

Only local SOM is supported.

=head1 SEE ALSO

perl(1).

=cut
