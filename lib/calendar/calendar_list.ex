defmodule GoogleCalendar.CalendarList do
  @moduledoc """
  Interact with google calendar list

  ## Differences between `Calendar` and `CalendarList`:

  Calendar contains calendar specific data (such as timezone, name). You should call insert on `Calendar`
  when creating a new calendar

  CalendarList is a collection of all calendar entries and contain more general information of each calendar,
  which shows distinction among them such as color, access roles.

  When you create a new calendar through calendars collection, it will be automatically added to your list

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
      opts = [params: [showDeleted: true]]

      GoogleCalendar.Calendar.get(client, event, opts)

      # Return result will be either `{:ok, action, result}` or `{:error, code, error_message}`
  """

  import GoogleCalendar.Response

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/users/me/calendarList"
  @content_type Application.get_env(:google_calendar, :content_type)

  @doc """
  `Function!/n` is similar to `Function/n` but raises error if an error occurs during the request
  """

  def list(client, opts \\ [], headers \\ []) do
    client
    |> OAuth2.Client.get(@base_url, headers, opts)
    |> show_resp("Get calendar list")
  end

  def list!(client, opts \\ [], headers \\ []) do
    case list(client, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def get(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> OAuth2.Client.get(path, headers, opts)
    |> show_resp("Get the calendar information")
  end

  def get!(client, calendar, opts \\ [], headers \\ []) do
    case get(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def insert(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.post(path, calendar, headers, opts)
    |> show_resp("Insert calendar")
  end

  def insert!(client, calendar, opts \\ [], headers \\ []) do
    case insert(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def update(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.put(path, calendar, headers, opts)
    |> show_resp("Update calendar")
  end

  def update!(client, calendar, opts \\ [], headers \\ []) do
    case update(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def patch(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.patch(path, calendar, headers, opts)
    |> show_resp("Update calendar")
  end

  def patch!(client, calendar, opts \\ [], headers \\ []) do
    case patch(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def delete(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> OAuth2.Client.delete(path, "", headers, opts)
    |> show_resp("Delete calendar")
  end

  def delete!(client, calendar, opts \\ [], headers \\ []) do
    case delete(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end
end