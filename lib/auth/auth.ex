defmodule GoogleCalendar.Auth do

  def authorize_url!(),   do: Google.authorize_url!([
    scope: "https://www.googleapis.com/auth/calendar",
    access_type: "offline",
  ])

  def get_token!(code),   do: Google.get_token!([code: code, response_type: nil])

  @doc """
  This action is reached via `/auth/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do

    # Exchange an auth code for an access token
    client = get_token!(code)

    conn
    |> Plug.Conn.put_session(:client, client)
  end
end