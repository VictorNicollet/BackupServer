(** Interacting with remote and local CouchDB databases. *)

(** Construct an URL on a specified database. *)
let url local segs = 
  "http://localhost:" ^ (if local then "5984" else "5985") ^ "/"
  ^ String.concat "/" segs

(** The replication url where replication requests are posted. *)
let url_replicate = 
  url true [ "_replicate" ]

(** The 'all databases' URL on the source database. *)
let url_all_databases = 
  url false [ "_all_dbs" ]

(** The local database status URL *)
let url_status = 
  url true [ "_active_tasks" ]


