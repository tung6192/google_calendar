defmodule GoogleCalendar.Event do
  @moduledoc """
  Interact with google events

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
  """

  import GoogleCalendar.Response
  OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/calendars"
  @content_type Application.get_env(:google_calendar, :content_type)

  @doc """
  `Function!/n` is similar to `Function/n` but raises error if an error occurs during the request
  """

  def list(client, %{calendar_id: calendar_id} = _event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events"

    client
    |> OAuth2.Client.get(path, headers, opts)
    |> show_resp("Get event list")
  end

  def list!(client, event, opts \\ [], headers \\ []) do
    case list(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def get(client, %{calendar_id: calendar_id, id: id} = _event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> OAuth2.Client.get(path, headers, opts)
    |> show_resp("Get event information")
  end

  def get!(client, event, opts \\ [], headers \\ []) do
    case get(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def insert(client, %{calendar_id: calendar_id} = event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.post(path, event, headers, opts)
    |> show_resp("Insert event")
  end

  def insert!(client, event, opts \\ [], headers \\ []) do
    case insert(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def update(client, %{calendar_id: calendar_id, id: id} = event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.put(path, event, headers, opts)
    |> show_resp("Update event")
  end

  def update!(client, event, opts \\ [], headers \\ []) do
    case update(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def patch(client, %{calendar_id: calendar_id, id: id} = event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"
    headers = headers ++ @content_type

    client
    |> OAuth2.Client.patch(path, event, headers, opts)
    |> show_resp("Update event")
  end

  def patch!(client, event, opts \\ [], headers \\ []) do
    case patch(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end

  def delete(client, %{calendar_id: calendar_id, id: id} = _event, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> OAuth2.Client.delete(path, "", headers, opts)
    |> show_resp("Delete event")
  end

  def delete!(client, event, opts \\ [], headers \\ []) do
    case delete(client, event, opts, headers) do
      {:ok, action, _resp} -> action
      {:error, code, message} -> raise "#{code} - #{message}"
    end
  end
end