(************************************************************
   url.ml		Created      : Sat Feb  8 19:44:23 2003
  			Last modified: Sat Dec 24 20:29:19 2016
   Compile: ocamlc.opt str.cma url.ml -o url #
  FTP Directory: sources/ocaml #
************************************************************)
(**
  not well tested url parser
  
  @author Takashi Masuyama <mamewo@dk9.so-net.ne.jp>
*)

exception IrreguralURL
exception Unsupported of string

let url_regexp = 
  Str.regexp "^\\([a-z]+\\)://\\([^/]+\\)\\([^\\?]*\\)\\(?\\(.*\\)\\)?$"

type hostname = string
type path = string
type protocol = HTTP
type t = { protocol : protocol;
	   hostname : string;
	   path : string;
	   param : string option }

(* FTP *)
    
let protocol_of_string s =
  if s = "http" then
    HTTP
  else
    raise (Unsupported(s))

let of_string url =
  if Str.string_match url_regexp url 0 then
    let proto =
      let tmp = Str.matched_group 1 url in
      protocol_of_string tmp in
    let host = Str.matched_group 2 url in
    let path =
      let tmp = Str.matched_group 3 url in
      if tmp = "" then "/"
      else tmp in
    let param = 
      try 
	let tmp = Str.matched_group 5 url in
	Some tmp
      with 
	Not_found -> None in
    { protocol = proto;
      hostname = host;
      path = path;
      param = param }
  else
    raise IrreguralURL
