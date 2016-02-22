# Class: clean_usr_local
#
# This module manages clean_usr_local
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class clean_usr_local {
    
  $man_dirs = [ "/usr/local/share/man/man1","/usr/local/share/man/man1x",
                "/usr/local/share/man/man2","/usr/local/share/man/man2x",
                "/usr/local/share/man/man3","/usr/local/share/man/man3x",
                "/usr/local/share/man/man4","/usr/local/share/man/man4x",
                "/usr/local/share/man/man5","/usr/local/share/man/man5x",
                "/usr/local/share/man/man6","/usr/local/share/man/man6x",
                "/usr/local/share/man/man7","/usr/local/share/man/man7x",
                "/usr/local/share/man/man8","/usr/local/share/man/man8x",
                "/usr/local/share/man/man9","/usr/local/share/man/man9x",
                "/usr/local/share/man/mann"]
  $share_dirs = ["/usr/local/share/applications","/usr/local/share/info","/usr/local/share/man"]
  $other_dirs = ["/usr/local/lib","/usr/local/lib64","/usr/local/sbin","/usr/local/etc",
                 "/usr/local/games","/usr/local/include","/usr/local/libexec","/usr/local/src",
                 "/usr/local/share"]
  
  rm_dir { $man_dirs:;
  } ->  
  rm_dir { $share_dirs:
  }->  
  rm_dir {$other_dirs:;}
  
}