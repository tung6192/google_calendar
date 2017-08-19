defmodule GoogleCalendar.Calendar do
  @moduledoc """
  Interact with google calendars

  ## Differences between `Calendar` and `CalendarList`:

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

      # Add query parameter to opts.Opts is `Keyword` type
      opts = [params: [showDeleted: true]]

      GoogleCalendar.Event.get(client, event, opts)

      # Return result will be either `{:ok, action, result}` or `{:error, code, error_message}`
  """

  import GoogleCalendar.Response

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/calendars"
  @content_type Application.get_env(:google_calendar, :content_type)

  @doc """
  `Function!/n` is similar to `Function/n` but raises error if an error occurs during the request
  """

  def get(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> OAuth2.Client.get(path, headers, opts)
    |> show_resp("Get calendar information")
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

  @doc """
  Only clear the primary calendar of an account
  """
  def clear(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}/clear"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.post(path, calendar, headers, opts)
    |> show_resp("Clear all events in the primary calendar")
  end

  def clear!(client, calendar, opts \\ [], headers \\ []) do
    case clear(client, calendar, opts, headers) do
      {:ok, action, resp} -> {action, resp}
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

end
