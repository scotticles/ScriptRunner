# Script Runner

### Needs a better name, but script runner works for now.

```
./backup
        -b /path/to/binary (required)
        -s /path/to/script (required)
        -pToken <Pushover Token>
        -pUserToken <Pushover User Token>
        -pTitle < message|Backup script > on host failed!
        -pDisable 1 Will turn off pushover if set to 1

./backup -b /bin/bash -s /opt/backup.sh \
         -pToken 2234dsafaf23 -pUserToken 3234dsafaf23 \
         -pTitle The clean up script
```

This will run backup.sh and if it fails it will put the error message into the pushover message and send it. The Title is half hardcoded because I wanted the hostname to be put in the title so "on $host failed!" is what will be in the title.

I currenlty do not have a license on this yet, if there is any interest I will add one.

### How to get it:

* #### One way to get it is in under the releases tab. It was compiled for 64bit Linux.

* #### Setup from source
    * Pull the github repo
    * install cpanminus  (sudo apt install cpanminus)
    * cpanm pp
    * cd /path/of/github/repo
    * cpanm --installdeps .  (this will install dependencies needed)
    * pp -o backup backup.pl (create a binary from the pl file)
    * chmod +x backup
    * ./backup

