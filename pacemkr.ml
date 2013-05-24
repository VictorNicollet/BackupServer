(** Send heartbeats to the pacemkr server. *)

(** Generate a heartbeat. *)
let send alert id detail = 
  let payload = Json.(serialize (Array [Object [
    "nature", String "Backups" ;
    "detail", String detail ;
    "id", String id ;
    "alert", Int alert ;
  ]])) in
  let call = new Http_client.post_raw Config.pacemkr payload in 
  (call # request_header `Base) # update_field "Content-Type" "application/json" ;
  let pipeline = new Http_client.pipeline in 
  pipeline # add call ;
  pipeline # run ()

(** Generate a "replication finished" heartbeat. *)
let send_replication_finished databases duration = 
  send 3600 "Replication"
    (Printf.sprintf "%d databases in %.2f seconds" databases duration)

(** Generate an "archive finished" heartbeat. *)
let send_archive_finished databases duration size = 
  send (3600 * 24 * 2) "Archive"
    (Printf.sprintf "%d databases in %.2f seconds (%d MB)" databases duration size)
