# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.GameOver do
  @moduledoc """
  Reacts to a "game over" state in the _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.Message
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.{Engine, Tally}

  @doc """
  Prints a game summary, a message and exits the game.
  """
  @spec exit(State.t(), keyword) :: no_return
  def exit(%State{} = state, option \\ [end_game: true]) do
    :ok = Tally.summary(state.tally, state.player_id)
    :ok = message(state) |> ANSI.puts()
    if option[:end_game], do: Engine.end_game(state.game_name)
    :ok = clear_messages()
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec message(State.t()) :: ANSI.ansilist()
  defp message(%State{tally: %Tally{request: request}} = state),
    do: Message.new(state, request)

  @spec clear_messages :: :ok
  defp clear_messages do
    receive do
      _ -> clear_messages()
    after
      0 -> :ok
    end
  end
end
