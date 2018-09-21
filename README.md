# GoogleCalendar

**Wrapper for google calendar API**

## Installation

The package can be installed by adding `google_calendar` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:google_calendar, "~> 0.1.0"}]
end
```

The docs can be found at [https://hexdocs.pm/google_calendar](https://hexdocs.pm/google_calendar).

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
    
### Interact with google events

Check list of optons in `https://developers.google.com/google-apps/calendar/v3/reference/events`

    # Access client which contains token from session if you have put it into session previously
    client = get_session(conn, "client")

    # Config your event variable. Event is `Map`/ `Nested Map` type
    event = %{calendar_id: "YOUR CALENDAR ID", id: "YOUR EVENT ID"}

    # Additional event information are included in event if you want to insert, update, or path
    event = %{
      calendar_id: "YOUR CALENDAR ID",
      id: "YOUR EVENT ID",
      start: %{
        date_time: "2017-08-20T05:20:00Z",
        timezone: "UTC"
      }
    }

    # Add query parameter to opts.Opts is `Keyword` type
    opts = [params: [maxResults: 5]]

    GoogleCalendar.Event.get(client, event, opts)

    # Return result will be either `{:ok, action, result}` or `{:error, code, error_message}`

### Interact with google calendars

Differences between `Calendar` and `CalendarList`:

Calendar contains calendar specific data (such as timezone, name). You should call insert on `Calendar`
when creating a new calendar

CalendarList is a collection of all calendar entries and contain more general information of each calendar,
which shows distinction among them such as color, access roles.

When you create a new calendar through calendars collection, it will be automatically added to your list

Check list of options in `https://developers.google.com/google-apps/calendar/v3/reference/calendars`

    # Access client which contains token from session if you have put it into session previously
    client = get_session(conn, "client")

    # Config your calenar variable. Calendar is `Map`/ `Nested Map` type
    calendar = %{id: "YOUR CALENDAR ID"}

    # Additional calendar information are included in event if you want to insert, update, or path
    calendar = %{
      id: "YOUR CALENDAR ID",
      defaultReminders: %{
        method: "YOUR METHOD"
      }
    }
