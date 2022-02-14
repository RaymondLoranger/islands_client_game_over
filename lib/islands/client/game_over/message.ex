defmodule Islands.Client.GameOver.Message do
  @moduledoc """
  Returns a "game over" message after a guess or stop request.
  """

  alias __MODULE__.{GuessCoord, Other, Stop}
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Request

  @doc """
  Returns a "game over" message after a guess or stop request.
  """
  @spec new(State.t(), Request.t()) :: ANSI.ansilist()
  def new(state, {:guess_coord, _player_id, _row, _col} = _request),
    do: GuessCoord.message(state)

  def new(state, {:stop, _player_id} = _request), do: Stop.message(state)
  def new(state, _other), do: Other.message(state)
end
