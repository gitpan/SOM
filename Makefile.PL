use ExtUtils::MakeMaker;

my @tk = grep /^TOOLKIT=/, @ARGV;
@ARGV = grep {not /^TOOLKIT=/} @ARGV;
my $inc = "";
my $lib = "";

if (@tk) {
    die "Multiple TOOLKIT=... arguments not allowed.\n" if @tk > 1;
    $tk[0] =~ /TOOLKIT=(.*)/;
    $inc = "-I$1/som/include";
    $lib = "-L$1/som/lib ";
}

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'SOM',
    'VERSION_FROM' => 'SOM.pm', # finds $VERSION
    'LIBS'	=> ["$lib-lsomtk"],   # e.g., '-lm' 
    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING' 
    'INC'	=> $inc,     # e.g., '-I/usr/include/other' 
);
