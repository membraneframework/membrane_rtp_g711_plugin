defmodule Membrane.RTP.G711.Plugin.App do
  @moduledoc false
  use Application
  alias Membrane.RTP.{G711, PayloadFormat}

  @spec start(atom, list) ::
          {:ok, pid} | {:error, {:already_started, pid} | {:shutdown, term} | term}
  def start(_type, _args) do
    for {encoding, pt} <- [{:PCMU, 0}, {:PCMA, 8}] do
      PayloadFormat.register(%PayloadFormat{
        encoding_name: encoding,
        payload_type: pt,
        payloader: G711.Payloader,
        depayloader: G711.Depayloader,
        frame_detector: fn _payload -> true end
      })
    end

    Supervisor.start_link([], strategy: :one_for_one, name: __MODULE__)
  end
end
