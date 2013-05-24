(** Archiving and compressing a copy of the database files. *)

(** Today's backup file. *)
let backup_file_current_name () =
  let time = Unix.gettimeofday () in
  let tm   = Unix.localtime time in 
  Printf.sprintf "%s/%04d-%02d-%02d.tar.gz" 
    Config.backup_location
    (1900 + tm.Unix.tm_year) (1 + tm.Unix.tm_mon) tm.Unix.tm_mday
  
(** Does today's backup file exists. *)
let current_backup_exists () = 
  Sys.file_exists (backup_file_current_name ()) 

(** The command run to generate the backup for a specified date. *)
let creation_command file databases =
   "tar -czf " ^ file ^ " " 
    ^ String.concat " " (List.map Config.database_file databases)

(** Create a backup *)
let create_backup databases = 
  let file = backup_file_current_name () in
  print_endline file ; 
  Log.info "Create backup %s" file ;
  let command = creation_command file databases in
  let result = Sys.command command in 
  if result <> 0 then (Log.error "Backup creation failed" ; assert false) 

