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

(** A typical replication request payload for the specified database. *)
let replication_request_payload db = 
  Json.(Object [
    "source", String (url false [db]) ;
    "target", String db ;
    "create_target", Bool true ;
  ]) 

(** The local database status, describes how many tasks are running
    that might prevent full replication or backup generation. *)
type status = {
  compaction  : int ;
  replication : int ;
}

(** From a "tasks" payload returned by the active tasks API, computes
    the current database status. *)
let status_of_tasks json = 
  let types = Json.(to_list (to_object (fun ~opt ~req -> to_string (req "type"))) json) in
  List.fold_left 
    (fun status -> function 
      | "database_compaction" -> { status with compaction = status.compaction + 1 }
      | "replication" -> { status with replication = status.replication +1 }
      | _ -> status) 
    { compaction = 0 ; replication = 0 } 
    types



