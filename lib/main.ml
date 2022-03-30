open Lwt
open Cohttp
open Cohttp_lwt_unix

type shape = 
  | Circle of (float)
  | Rectangle of (float * float)

let calcArea (Circle r) = Float.pi *. r *.  r
let calcArea (Rectangle (w, h)) = w *. h
let uri = Uri.of_string "https://open.spotify.com"

(* let headers = Header.add_list (Header.init ()) [
  ("cookie", "sp_t=b0c70214f033a941dd00b09d173bba35");
  ("authority", "api-partner.spotify.com");
  ("accept-language", "en");
  ("sec-ch-ua-mobile", "?0");
  ("authorization", "Bearer BQC8aJ11XnUGymM1U4MCselMib5omQr6qQ1WDPzgdgGO4fvMGVgGuVrQs7m_gO8yHkn0w1JI8xUkPvhDBnA");
  ("content-type", "application/json;charset=UTF-8");
  ("accept", "application/json");
  ("user-agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36");
  ("spotify-app-version", "1.1.81.88.g5e9024a5");
  ("app-platform", "WebPlayer");
  ("origin", "https://open.spotify.com");
  ("sec-fetch-site", "same-site");
  ("sec-fetch-mode", "cors");
  ("sec-fetch-dest", "empty");
  ("referer", "https://open.spotify.com/");
] *)

let body =
  Client.get (uri) >>= fun (resp, body) ->
  let code = resp |> Response.status |> Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Response.headers |> Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let main =
  let body = Lwt_main.run body in
  print_endline ("Received body\n" ^ body)