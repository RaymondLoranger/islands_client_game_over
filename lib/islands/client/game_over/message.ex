defmodule Islands.Client.GameOver.Message do
  alias __MODULE__.{GuessCoord, Other, Stop}
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Request

  @spec new(State.t(), Request.t()) :: ANSI.ansilist()
  def new(state, {:guess_coord, _player_id, _row, _col}),
    do: GuessCoord.message(state)

  def new(state, {:stop, _player_id}), do: Stop.message(state)
  def new(state, _other), do: Other.message(state)
end
