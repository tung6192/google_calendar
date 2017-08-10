defmodule GoogleCalendar.Calendar do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/calendars"
  @content_type Application.get_env(:google_calendar, :content_type)

  def get(client, %{id: id} = _calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}"

    client
    |> get!(path, headers, opts)
    |> show_resp("Get calendar information")
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

  @doc """
  Only clear the primary calendar of an account
  """
  def clear(client, %{id: id} = calendar, opts \\ [], headers \\ []) do
    path = "#{@base_url}/#{id}/clear"
    headers = Keyword.merge(@content_type, headers)

    client
    |> post!(path, calendar, headers, opts)
    |> show_resp("Clear all events in the primary calendar")
  end

end
