defmodule HexVersion.Web do  
  use Plug.Router
  require Logger
  require IEx
  import Plug.Conn.Query
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http HexVersion.Web, [], [port: 4000]
  end

  get "/" do
    conn
    |> send_resp(200, "ok")
    |> halt
  end

  get "/webhook/" do
    # IEx.pry
    query = decode(conn.query_string)
    [status, message] = 
      case query["hub.verify_token"] do
        "12" -> 
          [200 , query["hub.challenge"]]
        _ ->
          [400 , "Invalid Verify Token, expected: [12], got: [" <> query["hub.verify_token"] <> "]"]
      end
    conn
    |> send_resp(status, message)
    |> halt
  end

  post "/webhook/" do
    conn
    |> send_resp(200, '')
    |> halt
    IEx.pry
    conn
  end

  match _ do
    conn
    |> send_resp(404, "oops")
    |> halt
  end
end