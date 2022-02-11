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
  Reacts to a "game over" state.
  """
  @spec end_game(State.t()) :: no_return
  def end_game(%State{} = state), do: message(state) |> end_game(state)

  @doc """
  Prints a message and ends the game.
  """
  @spec end_game(ANSI.ansilist(), State.t()) :: no_return
  def end_game(message, %State{game_name: game_name} = state) do
    :ok = Tally.summary(state.tally, state.player_id)
    :ok = ANSI.puts(message)

    for _ <- 11 do
      IO.inspect(
        {state.player_id, Engine.game_pid(game_name)},
        label: :game_pid
      )

      Process.sleep(10)
    end

    # Game may already have been ended by the other client player.
    if Engine.game_pid(game_name), do: Engine.end_game(game_name)
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
