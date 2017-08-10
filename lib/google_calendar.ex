defmodule GoogleCalendar do
  @moduledoc """
  ### Google Calendar API

  Interact with Google `CalendarList`, `Calendar` and `Event`
  Main function includes `get list`, `get instance`, `insert`, `update`, and `delete`

  To access the authorize url, use `redirect conn, external: Google.authorize_url!()`
  To retrieve token, define route and callback uri in google oauth redirect uri `/auth/callback`

  ### Configuration

  Add the following configuration in your *.exs

      config :google_calendar, Google,
        client_id: GOOGLE_CLIENT_ID,
        client_secret: GOOGLE_CLIENT_SECRET,
        redirect_uri: "https://your_site.com/auth/callback"

  ### Call back function in auth_controller

      def callback(conn, %{"code" => code}) do
        # Exchange an auth code for an access token
        client = Google.get_token!(code: code)

        # You might want to put that client in session for latter and redirect url
        conn
        |> put_session(:client, client)
        |> redirect(to: "/")
      end

  """

end
