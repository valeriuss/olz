package Categoryselect;
require Exporter;
use strict 'refs';
use lib '..';
use CGI qw(:all);
use CGI::Carp qw/fatalsToBrowser/;
use DBI;
use Time::Local;
#use Main_page;
use Digest::MD5 qw(md5 md5_hex md5_base64);
@ISA = qw(Exporter) ;
@EXPORT = qw(categoryselectlist subcategoryselectlist categoryselectlist_o) ;
@EXPORT_OK = qw();
# installing the MySQL driver

use DBconnection qw($Ddbh $Ddatabase $Dport $Ddbuser $Ddbpassword $Dhostname);
$Ddsn = "DBI:mysql:database=$Ddatabase;host=$Dhostname;port=$Dport";
$Ddbh = DBI->connect($Ddsn, $Ddbuser, $Ddbpassword);
$Ddrh = DBI->install_driver("mysql");

sub categoryselectlist {
my $in = "@_";
my $query = " SELECT * FROM \`menu_user_main\` WHERE  \`root_level\` = \"root\" AND \`status\` = 1 ORDER BY \`asc\`"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my (@matrix) = ();
while (my @ref = $Dsth->fetchrow_array())
{    push(@matrix, [@ref]); }
$Dsth->finish();
$Ddbh->disconnect;
my $size = $#matrix ;
foreach ($matrix){
for ($digit = 0; $digit <=$size; $digit++)
     {
my $cat_index          		= $matrix[$digit][0];
my $cat_menu_ru        		= $matrix[$digit][3];

print "<option  "; if ($in eq  $cat_index)           { print "selected"}   ; print " value=\"$cat_index\">$cat_menu_ru</option>" ; 
  }}
};

sub categoryselectlist_o {
my $in = "@_";
my $qquery = " SELECT * FROM \`menu_user_main\` WHERE \`id_menu\` = \"$in\" AND \`status\` = \"1\" "  ;
$Dsth = $Ddbh->prepare("$qquery");
$Dsth->execute or die $Dsth->errstr;
@reff = $Dsth->fetchrow_array();
my $idmenu = $reff[0];
my $rootlevel = $reff[7];

my $query = " SELECT * FROM \`menu_user_main\` WHERE  \`root_level\` = \"$rootlevel\" AND \`status\` = 1 ORDER BY \`asc\`"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my (@matrix) = ();
while (my @ref = $Dsth->fetchrow_array())
{    push(@matrix, [@ref]); }
$Dsth->finish();
$Ddbh->disconnect;
my $size = $#matrix ;
foreach ($matrix){
for ($digit = 0; $digit <=$size; $digit++)
     {
my $cat_index          		= $matrix[$digit][0];
my $cat_menu_ru        		= $matrix[$digit][3];

print "<option  "; if ($in eq  $cat_index)           { print "selected"}   ; print " value=\"$cat_index\">$cat_menu_ru $menualias </option>" ; 
  }}
};


sub subcategoryselectlist {
my $in = "@_";

my $qquery = " SELECT * FROM \`menu_user_main\` WHERE \`id_menu\` = \"$in\" AND \`status\` = \"1\" "  ;
$Dsth = $Ddbh->prepare("$qquery");
$Dsth->execute or die $Dsth->errstr;
@reff = $Dsth->fetchrow_array();
my $idmenu = $reff[0];
my $rootlevel = $reff[1];

my $query = " SELECT * FROM \`menu_user_main\` WHERE  \`root_level\` = \"$rootlevel\" AND \`status\` = 1 ORDER BY \`asc\`"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my (@matrix) = ();
while (my @ref = $Dsth->fetchrow_array())
{    push(@matrix, [@ref]); }
$Dsth->finish();
$Ddbh->disconnect;
my $size = $#matrix ;
foreach ($matrix){
for ($digit = 0; $digit <=$size; $digit++)
     {
my $cat_index          		= $matrix[$digit][0];
my $cat_menu_ru        		= $matrix[$digit][3];

print "<option  "; if ($in eq  $cat_index)           { print "selected"}   ; print " value=\"$cat_index\">$cat_menu_ru $menualias </option>" ; 
  }}
};
