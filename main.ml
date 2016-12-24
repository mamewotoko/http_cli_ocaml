
let _ =
  let u = Url.of_string "http://mamewo.ddo.jp/" in
  print_endline (Http.get u)
