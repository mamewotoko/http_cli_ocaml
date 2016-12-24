
let _ =
  let u = Url.of_string "http://www.google.com/" in
  print_endline (Http.get u)
