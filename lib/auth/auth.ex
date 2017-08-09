defmodule GoogleCalendar.Auth do

  def authorize_url!("google"),   do: Google.authorize_url!([
    scope: "https://www.googleapis.com/auth/calendar",
    access_type: "offline",
  ])
  def authorize_url!(_), do: raise "No matching provider available"

  def get_token!("google", code),   do: Google.get_token!([code: code, response_type: nil])
  def get_token!(_, _), do: raise "No matching provider available"

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => provider, "code" => code}) do

    # Exchange an auth code for an access token
    client = get_token!(provider, code)

    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:client, client)
    |> redirect(to: "/")
  end
end