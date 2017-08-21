defmodule GoogleCalendar do
  @moduledoc """
  ### Google Calendar API

  Interact with Google `CalendarList`, `Calendar` and `Event`

  Main function includes `get list`, `get instance`, `insert`, `update`, and `delete`

  To access the authorize url, use `redirect conn, external: Google.authorize_url!()`

  To retrieve token, define route and callback uri in google oauth redirect uri `/auth/callback`

  ### Configuration

  Add the following configuration in your *.exs
      config :google_calendar, :base_url, "https://www.googleapis.com/calendar/v3"
      config :google_calendar, :content_type, [{"content-type", "application/json"}]

      config :google_calendar, Google,
        client_id: GOOGLE_CLIENT_ID,
        client_secret: GOOGLE_CLIENT_SECRET,
        redirect_uri: "https://your_site.com/auth/callback"

  ### Auth_controller
      # To retrieve authorize_url, call function
      Google.authorize_url!()

      # Call back function
      def callback(conn, %{"code" => code}) do
        # Exchange an auth code for an access token
        client = Google.get_token!(code: code)

        # You might want to put access_token in session for latter use and redirect url
        conn
        |> put_session(:token, client.token)
        |> redirect(to: "/")
      end

      # To recreate client
      token = get_session(conn, :token)
      client = Map.merge(Google.client(), %{token: token})

      # To refresh token, save your refresh token in database
      token = get_session(conn, :token)
      if OAuth2.AccessToken.expired?(token) do
        token = Map.merge(token, %{refresh_token: REFRESH_TOKEN})

        Google.client()
        |> Map.merge(%{token: token})
        |> OAuth2.Client.refresh_token!()
      end

  """

end
