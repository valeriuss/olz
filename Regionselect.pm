package Regionselect;
require Exporter;
use strict 'refs';
use lib '..';
use CGI qw(:all);
use CGI::Carp qw/fatalsToBrowser/;
use DBI;
use Time::Local;

use Digest::MD5 qw(md5 md5_hex md5_base64);
@ISA = qw(Exporter) ;
@EXPORT = qw(regionselectlist subregionselectlist  regionnumber2name subregionnumber2name) ;
@EXPORT_OK = qw();
# installing the MySQL driver

use DBconnection qw($Ddbh $Ddatabase $Dport $Ddbuser $Ddbpassword $Dhostname);
$Ddsn = "DBI:mysql:database=$Ddatabase;host=$Dhostname;port=$Dport";
$Ddbh = DBI->connect($Ddsn, $Ddbuser, $Ddbpassword);
$Ddrh = DBI->install_driver("mysql");

sub regionselectlist {
my $in = "@_";
my $query = " SELECT * FROM \`menu_user_region\` WHERE  \`root_level\` = \"root\" AND \`status\` = 1 ORDER BY \`menu_ru\`"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my (@matrix) = ();
while (my @ref = $Dsth->fetchrow_array())
{    push(@matrix, [@ref]); }
$Ddbh->disconnect;
$Dsth->finish();
my $size = $#matrix ;
foreach ($matrix){
for ($digit = 0; $digit <=$size; $digit++)
     {
my $reg_index          		= $matrix[$digit][0];
my $reg_menu_ru        		= $matrix[$digit][3];
print "<option  "; if ($in eq  $reg_index)           { print "selected"}   ; print " value=\"$reg_index\">$reg_menu_ru</option>" ; 
#print "<option value=\"$reg_index\">$reg_menu_ru</option>" ; 
  }}
};

sub regionnumber2name {
my $in = "@_";
my $query = " SELECT * FROM \`menu_user_region\` WHERE  \`id_menu\` = \"$in\" AND \`status\` = 1"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my @ref = $Dsth->fetchrow_array();
$Ddbh->disconnect;
my $reg_menu_ru  		 = $ref[3];
return ($reg_menu_ru) ; 
};

sub subregionselectlist {
my $in = "@_";

my $qquery = " SELECT * FROM \`menu_user_region\` WHERE \`id_menu\` = \"$in\" AND \`status\` = \"1\" "  ;
$Dsth = $Ddbh->prepare("$qquery");
$Dsth->execute or die $Dsth->errstr;
@reff = $Dsth->fetchrow_array();
my $idmenu = $reff[0];
my $rootlevel = $reff[7];

my $query = " SELECT * FROM \`menu_user_region\` WHERE  \`root_level\` = \"$rootlevel\" AND \`status\` = 1 ORDER BY \`id_menu\`"  ;

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
my $reg_index          		= $matrix[$digit][0];
my $reg_menu_ru        		= $matrix[$digit][3];
print "<option  "; if ($in ==  $reg_index)           { print "selected"}   ; print " value=\"$reg_index\">$reg_menu_ru</option>" ; 
#print "<option value=\"$reg_index\">$reg_menu_ru</option>" ; 
  }}
};

sub subregionnumber2name {
my $in = "@_";
my $query = " SELECT * FROM \`menu_user_region\` WHERE  \`id_menu\` = \"$in\" AND \`status\` = 1"  ;
$Dsth = $Ddbh->prepare("$query");
$Dsth->execute or die $Dsth->errstr;
my @ref = $Dsth->fetchrow_array();
$Ddbh->disconnect;
my $reg_menu_ru  		 = $ref[3];
return ($reg_menu_ru) ; 
};
