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
  Prints a message and ends the game.
  """
  @spec end_game(State.t(), boolean) :: no_return
  def end_game(%State{game_name: game_name} = state, notified?) do
    :ok = Tally.summary(state.tally, state.player_id)
    :ok = message(state) |> ANSI.puts()
    # Only the notified player stops the game.
    if notified?, do: Engine.end_game(game_name)
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
