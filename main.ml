(** Includes all modules necessary for operation *)

let rec wait_for_idle_database () = 
  let status = Couchdb.query_current_status () in 
  if not (Couchdb.idle_status status) then (
    Log.trace "Wait... %s" (Couchdb.string_of_status status) ;
    Unix.sleep 5 ;
    wait_for_idle_database ())

let rec start () = 
  let databases = Couchdb.query_all_databases () in
  let databases = List.filter Config.filter_database databases in 

  (* Run all replication processes. *)
  List.iter Couchdb.run_replication_request databases ;
  wait_for_idle_database () ;

  (* Run all compaction processes. *)
  List.iter Couchdb.run_compaction_request databases ;
  wait_for_idle_database () ;

  () 

let () = 
  start ()
  
  
