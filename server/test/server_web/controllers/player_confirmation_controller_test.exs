defmodule ServerWeb.PlayerConfirmationControllerTest do
  use ServerWeb.ConnCase, async: true

  alias Server.Accounts
  alias Server.Repo
  import Server.AccountsFixtures

  setup do
    %{player: player_fixture()}
  end

  describe "GET /players/confirm" do
    test "renders the confirmation page", %{conn: conn} do
      conn = get(conn, Routes.player_confirmation_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Resend confirmation instructions</h1>"
    end
  end

  describe "POST /players/confirm" do
    @tag :capture_log
    test "sends a new confirmation token", %{conn: conn, player: player} do
      conn =
        post(conn, Routes.player_confirmation_path(conn, :create), %{
          "player" => %{"email" => player.email}
        })

      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "If your email is in our system"
      assert Repo.get_by!(Accounts.PlayerToken, player_id: player.id).context == "confirm"
    end

    test "does not send confirmation token if account is confirmed", %{conn: conn, player: player} do
      Repo.update!(Accounts.Player.confirm_changeset(player))

      conn =
        post(conn, Routes.player_confirmation_path(conn, :create), %{
          "player" => %{"email" => player.email}
        })

      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "If your email is in our system"
      refute Repo.get_by(Accounts.PlayerToken, player_id: player.id)
    end

    test "does not send confirmation token if email is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.player_confirmation_path(conn, :create), %{
          "player" => %{"email" => "unknown@example.com"}
        })

      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "If your email is in our system"
      assert Repo.all(Accounts.PlayerToken) == []
    end
  end

  describe "GET /players/confirm/:token" do
    test "confirms the given token once", %{conn: conn, player: player} do
      token =
        extract_player_token(fn url ->
          Accounts.deliver_player_confirmation_instructions(player, url)
        end)

      conn = get(conn, Routes.player_confirmation_path(conn, :confirm, token))
      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "Account confirmed successfully"
      assert Accounts.get_player!(player.id).confirmed_at
      refute get_session(conn, :player_token)
      assert Repo.all(Accounts.PlayerToken) == []

      # When not logged in
      conn = get(conn, Routes.player_confirmation_path(conn, :confirm, token))
      assert redirected_to(conn) == "/"
      assert get_flash(conn, :error) =~ "Account confirmation link is invalid or it has expired"

      # When logged in
      conn =
        build_conn()
        |> log_in_player(player)
        |> get(Routes.player_confirmation_path(conn, :confirm, token))

      assert redirected_to(conn) == "/"
      refute get_flash(conn, :error)
    end

    test "does not confirm email with invalid token", %{conn: conn, player: player} do
      conn = get(conn, Routes.player_confirmation_path(conn, :confirm, "oops"))
      assert redirected_to(conn) == "/"
      assert get_flash(conn, :error) =~ "Account confirmation link is invalid or it has expired"
      refute Accounts.get_player!(player.id).confirmed_at
    end
  end
end
