defmodule Membrane.RTP.G711.Payloader do
  @moduledoc """
  Parses G711 payloads into parseable RTP packets.
  """

  use Membrane.Filter

  alias Membrane.{G711, RemoteStream, RTP}

  def_input_pad :input,
    accepted_format:
      any_of(
        %G711{},
        %RemoteStream{type: :packetized, content_format: content_format}
        when content_format in [G711, nil]
      ),
    flow_control: :auto

  def_output_pad :output, accepted_format: RTP, flow_control: :auto

  @impl true
  def handle_stream_format(:input, _stream_format, _ctx, state) do
    {[stream_format: {:output, %RTP{}}], state}
  end

  @impl true
  def handle_buffer(:input, buffer, _ctx, state) do
    {[buffer: {:output, buffer}], state}
  end
end
