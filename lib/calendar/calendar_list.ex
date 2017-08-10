defmodule GoogleCalendar.CalendarList do
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