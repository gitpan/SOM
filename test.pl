# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..35\n"; }
END {print "not ok 1\n" unless $loaded;}
use SOM ':types', ':class';
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$class = Find_Class("Animal", 0, 0);

print <<EOP unless $class;
# Could not find class Animal from toolkit REXX SOM sample
# Make sure you build this class in \$TOOLKIT/samples/rexx/som
# put animals.dll on LIBPATH, and have \$ENV{SOMIR} contain
#   \$TOOLKIT\\SAMPLES\\REXX\\SOM\\ANIMAL\\ORXSMP.IR
# (\$TOOLKIT is the location of your OS/2 toolkit), or do the same with
#   \$OREXX/samples                       directory instead of
#   \$TOOLKIT\\SAMPLES\\REXX\\SOM\\ANIMAL directory.
EOP

print "not " unless $class;
print "ok 2\n";

$obj = $class->NewObject;
print "not " unless $obj;
print "ok 3\n";

$class1 = Find_Class("Dog", 0, 0);
print "not " unless $class1;
print "ok 4\n";

$obj1 = $class1->NewObject;
print "not " unless $obj1;
print "ok 5\n";

$obj->Dispatch0("display");
print "ok 6\n";

$obj->Dispatch0("talk");
print "ok 7\n";

$obj1->Dispatch0("display");
print "ok 8\n";

$obj1->Dispatch0("talk");
print "ok 9\n";

sub make_template_oidl {
  join '', 'o', map chr(33 + $_), @_;
}

sub make_template {
  join '', 'n', map chr(33 + $_), @_;
}

$get_string = make_template_oidl tk_string;
print "# '$get_string'\nok 10\n";
print "# '", tk_string. "'\n";

$set_string = make_template_oidl tk_void, tk_string;
print "# '$set_string'\nok 11\n";
print "# '", tk_void. "'\n";

$genus = $obj->Dispatch_templ("_get_genus", $get_string);
print "ok 12\n";
print "# '$genus'\n";

$genus1 = $obj1->Dispatch_templ("_get_genus", $get_string);
print "ok 13\n";
print "# '$genus1'\n";

$obj1->Dispatch_templ("_set_breed", $set_string, "chachacha");
print "ok 14\n";
print "# '$breed1'\n";

$obj1->Dispatch0("display");
print "ok 15\n";

$breed1 = $obj1->Dispatch_templ("_get_breed", $get_string);
print "ok 16\n";
#print "# '$breed1'\n";
$breed1 eq 'chachacha' or print "not ";
print "ok 17\n";

$repo = RepositoryNew;
print "ok 18\n";
ref $repo eq 'SOMObjectPtr' or print "not ";
print "ok 19\n";

$classmgrO = SOMClassMgrObject;
print "ok 20\n";
ref $classmgrO eq 'SOMObjectPtr' or print "#'$classmgrO'\nnot ";
print "ok 21\n";

$classmgr = SOMClassMgr;
print "ok 22\n";
ref $classmgr eq 'SOMClassPtr' or print "not ";
print "ok 23\n";

$SOMclass = SOMClass;
print "ok 24\n";
ref $SOMclass eq 'SOMClassPtr' or print "not ";
print "ok 25\n";

$SOMobject = SOMObject;
print "ok 26\n";
ref $SOMobject eq 'SOMClassPtr' or print "not ";
print "ok 27\n";

$clcl = $SOMclass->GetClass;
print "ok 28\n";
$$clcl eq $$SOMclass or print "not ";
print "ok 29\n";

$clob = $SOMobject->GetClass;
print "ok 30\n";
$$clob eq $$SOMclass or print "not ";
print "ok 31\n";

$clclm = $classmgr->GetClass;
print "ok 32\n";
$$clclm eq $$SOMclass or print "not ";
print "ok 33\n";

$clclmo = $classmgrO->GetClass;
print "ok 34\n";
$$clclmo eq $$classmgr or print "not ";
print "ok 35\n";

eval { $obj1->Dispatch_templ("nonesuch", $get_string); 1 }
  or print "not ";
print "ok 18\n";

$@ =~ /error\s+dispatching/i or print "not ";
print "ok 19\n";
