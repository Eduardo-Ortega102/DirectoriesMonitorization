## What is in this repository? ##

In this repository you will find two scripts: `snapshot.ksh` and `compare_snapshot.ksh`. These two shell scripts together provides a way to monitor changes performed on files stored in these directories: /bin, /sbin, /usr/bin, and /usr/sbin.

## Script 1: snapshot.ksh

This script prints, into the standard output, information about each file stored in /bin, /sbin, /usr/bin, and /usr/sbin directories; so, you can pipe it to whatever file you want in order to store it.

The information about each file is printed following this structure: `file_permissions:file_checksum:file_path`


## Script 2: compare_snapshot.ksh


## How do I use these scripts? 

Before use them, make sure you have this:

1. A Unix shell (the shell in which these scripts have been tested is `KSH`)
2. The commands: `stat`, `md5sum` and `tr`