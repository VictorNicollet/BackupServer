(** Configuration file. Edit this file to run the backup server on your own. *)

(** Pacemkr configuration *)
let pacemkr = ""

(** Source server and user. This is where the remote CouchDB database runs. *)
let remote_couchdb_server = "backups@prod-01.runorg.com"

(** Where to store the backups. *)
let backup_location = "/var/backups/couchdb" 

(** Where to find CouchDB files. *)
let database_file db = "/var/lib/couchdb/1.1.1/" ^ db ^ ".couch"

(** Database filter *)
let filter_database db = 
  BatString.starts_with db "dev-" 
  && not (List.mem db [
    "prod-alog" ;
    "prod-async" ;
    "prod-account-line" ;
    "prod-account-line-v" ;
    "prod-audit-profile" ;
    "prod-avatar-grid-u" ;
    "prod-avatar-grid-l" ;
    "prod-broadcast-import" ;
    "prod-broadcast-rss-u" ;
    "prod-chat-line" ;
    "prod-chat-participant" ;
    "prod-chat-room" ;
    "prod-cms" ;
    "prod-error" ;
    "prod-inbox-line-view" ;
    "prod-polling-content" ;
    "prod-polling-info" ;
    "prod-mailing" ;
    "prod-notify" ;
    "prod-notify-freq" ;
    "prod-paypal" ;
    "prod-paypal-v" ;
    "prod-voeux" ;
    "prod-vote" ;
    "prod-template" ;
    "prod-vote-ballot" ;
  ]) 
