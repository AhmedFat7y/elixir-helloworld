defmodule FBMessengerAPI.Base do
  use HTTPotion.Base
  @config %{
    protocol: "https",
    host: "graph.facebook.com",
  }
  defstruct [:sender, :recipient, :timestamp, :postback]

  def prepend_protocol(url) do
    @config.protocol <> "://" <> url
  end

  def process_url(url) do
    @config.host <> url
  end

  def process_request_headers(headers) do
    headers
    |> Dict.put(:"Accept", "*/*")
    |> Dict.put(:"Content-Type", "application/json")
    |> Dict.put(:"User-Agent", "messenger-bot")
  end

  def process_response_body(body) do
    body
    |> IO.iodata_to_binary
    |> Poison.decode()
  end
end

defmodule FBMessengerAPI do
  require IEx
  @config %{
    page_access_token: "EAAM500J0ZBGMBAOgnIGaeIjwUyl6kEZAMlzUmNvZA6Heeu22I98Jepbgwzg2WKBEqiPd2O8JZBpZBbpaEn3dTl2qHzZCcnvj3PAUrw2z8AmP8mStIihrNidQmOVECgunBBZBvrZAlmKWpLHeihVqZCi6ZBQGjbaWLADBDpAli2YXiZBaQZDZD",
    messages_url: '/v2.6/me/messages',
  }
  def post_request(url, body) do
    IO.inspect("body: #{body}")
    FBMessengerAPI.Base.post(url, [query: %{access_token: @config.page_access_token}, body: body, ibrowse: [ proxy_host: '127.0.0.1', proxy_port: 8888 ] ])
  end
  def mark_seen(messaging_list) do
    messaging_list
    |> Enum.each(fn messaging_item ->
      IO.inspect(messaging_item)
      # IEx.pry
      {_, body} = Poison.encode(%{"recipient": %{"id": messaging_item["sender"]["id"]}, "sender_action": "mark_seen"})
      post_request(@config.messages_url, body)
      |> IO.inspect
    end)
  end
  def send_message(sender, text) do
    post_request @config.messages_url, "{\"recipient\": {\"id\": \"#{sender}\"},\"message\": {\"text\": \"#{text}\"}}"
  end
end