defmodule Islands.Client.GameOver.Message.Other do
  @moduledoc """
  Returns a "game over" message after an unexpected request.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State

  @doc """
  Returns a "game over" message after an unexpected request.
  """
  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{} = state) do
    [
      :fuchsia_background,
      :light_white,
      "Game over for an unknown reason...",
      :reset,
      "\nState: #{inspect(state)}"
    ]
  end
end
