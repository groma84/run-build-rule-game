defmodule ServerWeb.PlayerRegistrationController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.Player
  alias ServerWeb.PlayerAuth

  def new(conn, _params) do
    changeset = Accounts.change_player_registration(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    case Accounts.register_player(player_params) do
      {:ok, player} ->
        {:ok, _} =
          Accounts.deliver_player_confirmation_instructions(
            player,
            &Routes.player_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "Player created successfully.")
        |> PlayerAuth.log_in_player(player)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
