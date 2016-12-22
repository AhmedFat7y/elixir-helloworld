# {
#   "object":"page",
#   "entry":[
#     {
#       "id":"PAGE_ID",
#       "time":1458692752478,
#       "messaging":[
#           {
#             "sender":{
#               "id":"USER_ID"
#             },
#             "recipient":{
#               "id":"PAGE_ID"
#             },
#             "timestamp":1458692752478,
#             "message":{
#               "mid":"mid.1458696618141:b4ef9d19ec21086067",
#               "seq":51,
#               "attachments":[
#                 {
#                   "type":"image",
#                   "payload":{
#                     "url":"IMAGE_URL"
#                   }
#                 }
#               ]
#             }
#           }
#       ]
#     }
#   ]
# }
# MainPayload
defmodule IncomingMessage do
  @derive [Poison.Encoder]
  defstruct [:object, :entry]
end

defmodule Entry do
  @derive [Poison.Encoder]
  defstruct [:id, :time, :messaging]
end
defmodule Messaging do
  @derive [Poison.Encoder]
  defstruct [:sender, :recipient, :timestamp, :message, :postback]
end

defmodule Message do
  @derive [Poison.Encoder]
  defstruct [:mid, :seq, :text, :attachments, :quick_reply]
end
defmodule Attachment do
  @derive [Poison.Encoder]
  defstruct [:type, :payload]
end
defmodule QuickReply do
  @derive [Poison.Encoder]
  defstruct [:payload]
end

defmodule PostBack do
  @derive [Poison.Encoder]
  defstruct [:payload, :referral]
end

defmodule Referral do
  @derive [Poison.Encoder]
  defstruct [:ref, :source, :type]
end

# x = to_string '{"object":"page","entry":[{"id":"PAGE_ID","time":1458692752478,"messaging":[{"sender":{"id":"USER_ID"},"recipient":{"id":"PAGE_ID"}},{"sender":{"id":"USER_ID2"},"recipient":{"id":"PAGE_ID"}}]},{"id":"PAGE_ID2","time":1458692752478,"messaging":[{"sender":{"id":"USER_ID"},"recipient":{"id":"PAGE_ID"}},{"sender":{"id":"USER_ID2"},"recipient":{"id":"PAGE_ID"}}]}]}'
# Poison.decode(x, as: %IncomingMessage{  entry: [%Entry{    messaging: [%Messaging{      message: %Message{        quick_reply: %QuickReply{},         attachments: [%Attachment{}]      },      postback: %PostBack{        referral: %Referral{}      }    }]  }]})