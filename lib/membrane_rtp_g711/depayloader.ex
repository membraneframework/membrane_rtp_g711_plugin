defmodule Membrane.RTP.G711.Depayloader do
  @moduledoc """
  Parses RTP payloads into parseable G711 packets.
  """

  use Membrane.Filter

  alias Membrane.{G711, RemoteStream, RTP}

  def_input_pad :input, accepted_format: RTP, demand_mode: :auto

  def_output_pad :output,
    accepted_format: %RemoteStream{type: :packetized, content_format: G711},
    demand_mode: :auto

  @impl true
  def handle_stream_format(:input, _stream_format, _context, state) do
    {
      [stream_format: {:output, %RemoteStream{type: :packetized, content_format: G711}}],
      state
    }
  end

  @impl true
  def handle_process(:input, buffer, _ctx, state) do
    {[buffer: {:output, buffer}], state}
  end
end
