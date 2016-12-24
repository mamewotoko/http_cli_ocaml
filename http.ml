(************************************************************
   http.ml		Created      : Sat Feb  8 19:40:34 2003
  			Last modified: Sun Dec 25 05:24:51 2016
  Compile: ocamlc.opt -g str.cma unix.cma url.cmo http.ml -o http #
  FTP Directory: sources/ocaml #
************************************************************)
(**

  @author Takashi Masuyama <mamewo@dk9.so-net.ne.jp>

*)
module Unix = UnixLabels

exception Error of string

(* TODO: get from command line *)
let http_port = 80

open Url

let connect host port =
  let addr = Unix.gethostbyname host in
  let s = 
    Unix.socket ~domain:Unix.PF_INET ~kind:Unix.SOCK_STREAM ~protocol:0 in
  Unix.connect s (Unix.ADDR_INET(addr.Unix.h_addr_list.(0), port)); s

let get url =
  let _ = print_endline "get" in
  if url.protocol <> HTTP then
    raise (Error ("irregural protocol"))
  else
    let request_string =
      Printf.sprintf "GET %s\r\n\r\n" url.path in
    let _ = print_endline request_string;  flush stdout in
    let s = connect url.hostname http_port in
    let buf = String.make 1 '\000' in
    let c = ref "" in
    let _ =
      Unix.write s request_string 0 (String.length request_string) in
    (*    let _ = Printf.printf "size = %d" size in *)
    try
      while true do
	let num = Unix.read s buf 0 1 in
	if num = 0 then
	  raise End_of_file
	else
	  c := !c^(String.sub buf 0 1)
      done;
      !c
    with
      End_of_file -> !c
