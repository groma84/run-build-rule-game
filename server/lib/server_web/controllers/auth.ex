defmodule ServerWeb.AuthController do
  use ServerWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    IO.inspect("#{Helpers.callback_url(conn)}", label: "request callback_url")
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  @spec callback(%{:assigns => map, optional(any) => any}, any) :: any
  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    IO.inspect(fails, label: "ueberauth_callback for failed")

    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.inspect(auth, label: "ueberauth_callback for success")

    conn
  end
end
