defmodule GoogleCalendar.CalendarList do
  @moduledoc """
  Interact with google calendar list
  Check list of options in `https://developers.google.com/google-apps/calendar/v3/reference/calendarList`

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

      # Add query parameter to opts.Opts is `Keyword` type
      opts = opts = [params: [showDeleted: true]]

      GoogleCalendar.Event.get(client, event, opts)

      # Return result will be either `{:ok, action, result}` or `{:error, code, error_message}`
  """

  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/users/me/calendarList"
  @content_type Application.get_env(:google_calendar, :content_type)

  def list(client, opts \\ [], headers \\ []) do
    client
    |> get!(@base_url, headers, opts)
    |> show_resp("Get calendar list")
  end

  def get(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> get!(path, headers, opts)
    |> show_resp("Get the calendar information")
  end

  def insert(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = Keyword.merge(@content_type, headers)

    client
    |> post!(path, calendar, headers, opts)
    |> show_resp("Insert calendar")
  end

  def update(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = Keyword.merge(@content_type, headers)

    client
    |> put!(path, calendar, headers, opts)
    |> show_resp("Update calendar")
  end

  def patch(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = Keyword.merge(@content_type, headers)

    client
    |> patch!(path, calendar, headers, opts)
    |> show_resp("Update calendar")
  end

  def delete(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> delete!(path, "", headers, opts)
    |> show_resp("Delete calendar")
  end
end