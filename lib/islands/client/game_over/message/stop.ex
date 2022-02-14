defmodule Islands.Client.GameOver.Message.Stop do
  @moduledoc """
  Returns a "game over" message after a stop request.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

  @doc """
  Returns a "game over" message after a stop request.
  """
  @spec message(State.t()) :: ANSI.ansilist()
  def message(
        %State{
          player_id: player_id,
          tally: %Tally{request: {:stop, player_id}}
        } = state
      ) do
    [
      :fuchsia_background,
      :light_white,
      "#{state.player_name}, looks like you gave up."
    ]
  end

  def message(%State{tally: %Tally{request: {:stop, _player_id}}} = state) do
    [
      :fuchsia_background,
      :light_white,
      "#{state.player_name}, your opponent gave up."
    ]
  end
end
