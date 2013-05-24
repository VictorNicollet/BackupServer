## Connecting to the production server

Create an SSH key with no passphrase. Use a key description formatted as "Backup server YYYY/MM/DD": 

    ssh-keygen -rsa

Copy the contents of the public key: 

    cat .ssh/id_rsa.pub

Connect to the production server as the `backup` user, append the public key to the authorized keys file. 
 
    cat >> .ssh/authorized_keys
    
## Building the software

As root, make sure the necessary elements are present. On a Debian system, for example: 

    apt-get install \
      git \
      make \
      ocaml-nox \
      libocamlnet-ocaml-dev \
      libcurl-ocaml-dev \
      libbatteries-ocaml-dev \
      couchdb \
      daemontools 

Fetch the code from GitHub:

    git clone git://github.com/RunOrg/BackupServer.git

Complete the `config.ml` file, then make everything:

    make -C BackupServer

## Running the software

Also as root (or any user that has access to the CouchDB files and
to the destination folder `/var/backups/couchdb`).
 
Use a watchdog:

    supervise BackupServer
