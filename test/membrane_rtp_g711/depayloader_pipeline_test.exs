defmodule Membrane.RTP.Opus.DepayloaderPipelineTest do
  use ExUnit.Case

  import Membrane.ChildrenSpec
  import Membrane.Testing.Assertions

  alias Membrane.RTP
  alias Membrane.RTP.G711.Depayloader
  alias Membrane.Testing

  describe "Depayloader in a pipeline" do
    test "does not crash when processing garbage" do
      base_range = 1..100

      data =
        for elem <- base_range do
          <<elem::256>>
        end

      pipeline =
        Testing.Pipeline.start_link_supervised!(
          spec:
            child(:source, %Testing.Source{output: data, stream_format: %RTP{}})
            |> child(:depayloader, Depayloader)
            |> child(:sink, %Testing.Sink{})
        )

      for elem <- base_range do
        assert_sink_buffer(pipeline, :sink, %Membrane.Buffer{payload: <<^elem::256>>})
      end

      Testing.Pipeline.terminate(pipeline)
    end
  end
end
