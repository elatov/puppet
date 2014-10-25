#!/usr/bin/env perl
# ex : ^(hd[a-z]+|sd[a-z]+|vd[a-z]+|dm-[0-9]+|drbd[0-9]+)$	
#      ^(loop[0-9]+|sr[0-9]*|fd[0-9]*)$
$firstline = 1;
print "{\n";
print "\t\"data\":[\n\n";

for (`cat /proc/diskstats`)
  {
  ($major,$minor,$disk) = m/^\s*([0-9]+)\s+([0-9]+)\s+(\S+)\s.*$/;
  #print("$major $minor $disk $diskdev $dmname $vmid $vmname \n");

  print "\t,\n" if not $firstline;
  $firstline = 0;

  print "\t{\n";
  print "\t\t\"{#DISK}\":\"$disk\"\n";
  print "\t}\n";
  }

print "\n\t]\n";
print "}\n";
