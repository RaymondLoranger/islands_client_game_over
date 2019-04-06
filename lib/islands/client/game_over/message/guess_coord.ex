defmodule Islands.Client.GameOver.Message.GuessCoord do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

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
