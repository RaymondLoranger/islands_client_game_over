# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.GameOver do
  @moduledoc """
  Handles a _game over_ state in the _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.Message
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.{State, Summary}
  alias Islands.{Engine, Tally}

  @spec end_game(State.t()) :: no_return
  def end_game(%State{} = state), do: message(state) |> end_game(state)

  @spec end_game(ANSI.ansilist(), State.t()) :: no_return
  def end_game(message, %State{game_name: game_name} = state) do
    Summary.display(state)
    ANSI.puts(message)
    Engine.end_game(game_name)
    clear_messages()
    self() |> Process.exit(:normal)
  end

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{tally: %Tally{request: request}} = state),
    do: Message.new(state, request)

  @spec clear_messages :: :ok
  def clear_messages do
    receive do
      _ -> clear_messages()
    after
      0 -> :ok
    end
  end
end
