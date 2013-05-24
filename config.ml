(** Configuration file. Edit this file to run the backup server on your own. *)

(** Source server and user. This is where the remote CouchDB database runs. *)
let remote_couchdb_server = "backups@prod-01.runorg.com"

(** Database filtr *)
let filter_database db = 
  BatString.starts_with db "dev-" 
  && not (List.mem db [
    "prod-alog" ;
    "prod-async" ;
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
