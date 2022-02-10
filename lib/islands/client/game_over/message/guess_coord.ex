defmodule Islands.Client.GameOver.Message.GuessCoord do
  @moduledoc """
  Returns a "game over" message after a `:guess_coord` request.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

  @doc """
  Returns a "game over" message after a `:guess_coord` request.
  """
  @spec message(State.t()) :: ANSI.ansilist()
  def message(
        %State{
          player_id: player_id,
          tally: %Tally{request: {:guess_coord, player_id, _row, _col}}
        } = state
      ) do
    [
      :fuchsia_background,
      :light_white,
      "Bravo, #{state.player_name}, you WON!"
    ]
  end

  def message(
        %State{
          tally: %Tally{request: {:guess_coord, _player_id, _row, _col}}
        } = state
      ) do
    [
      :fuchsia_background,
      :light_white,
      "Sorry, #{state.player_name}, you lost."
    ]
  end
end
