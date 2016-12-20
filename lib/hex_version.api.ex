defmodule HexVersion.Api do  
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(HexVersion.Web, [])
    ]

    opts = [strategy: :one_for_one, name: HexVersion.Supervisor]
    Supervisor.start_link(children, opts)
  end
end  