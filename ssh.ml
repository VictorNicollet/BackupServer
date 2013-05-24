(** SSH tunnel manipulation. *)

(** Create the tunnel and keep it open for as long as possible. *)
let create_tunnel () = 
  let command = "nohup ssh " ^ Config.remote_couchdb_server ^ " -L 5985:localhost:5984 -T -N" in
  let result = Sys.command command in 
  if result <> 0 then (Log.error "Command '%s' failed" command ; assert false)

