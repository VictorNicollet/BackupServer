(** Includes all modules necessary for operation *)

let rec wait_for_idle_database () = 
  let status = Couchdb.query_current_status () in 
  if not (Couchdb.idle_status status) then (
    Log.trace "Wait... %s" (Couchdb.string_of_status status) ;
    Unix.sleep 5 ;
    wait_for_idle_database ())

let rec loop () = 

  let start = Unix.gettimeofday () in 

  (* Always get a fresh list of databases from production server. *)
  let databases = Couchdb.query_all_databases () in
  let databases = List.filter Config.filter_database databases in 

  (* Run all replication processes. *)
  List.iter Couchdb.run_replication_request databases ;
  wait_for_idle_database () ;

  (* Run all compaction processes. *)
  List.iter Couchdb.run_compaction_request databases ;
  wait_for_idle_database () ;

  let delta = Unix.gettimeofday () -. start in
  Pacemkr.send_replication_finished (List.length databases) delta ; 

  (* Create the backup for today if it does not exist yet. *)
  if not (Tar.current_backup_exists ()) then begin 
    let start = Unix.gettimeofday () in 
    let size = Tar.create_backup databases in
    let delta = Unix.gettimeofday () -. start in 
    Pacemkr.send_archive_finished (List.length databases) delta size 
  end ; 

  (* Run again in 30 minutes. *)
  Log.trace "Sleeping..." ;
  Unix.sleep 1800 ;
  loop () 

let () = 
  loop ()
  
  
