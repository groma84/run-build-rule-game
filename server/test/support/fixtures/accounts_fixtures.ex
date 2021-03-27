defmodule Server.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Accounts` context.
  """

  def unique_player_email, do: "player#{System.unique_integer()}@example.com"
  def valid_player_password, do: "hello world!"

  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        email: unique_player_email(),
        password: valid_player_password()
      })
      |> Server.Accounts.register_player()

    player
  end

  def extract_player_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
