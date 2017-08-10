defmodule GoogleCalendar.Calendar do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/calendars"
  @content_type Application.get_env(:google_calendar, :content_type)

  def get(client, %{id: id}) do
    path = "#{@base_url}/#{id}"

    client
    |> get!(path)
    |> show_resp("Get calendar information")
  end

  def insert(client, %{id: id} = calendar) do
    path = "#{@base_url}/#{id}"

    client
    |> post!(path, calendar, [@content_type])
    |> show_resp("Insert calendar")
  end

  def update(client, %{id: id} = calendar) do
    path = "#{@base_url}/#{id}"

    client
    |> put!(path, calendar, [@content_type])
    |> show_resp("Update calendar")
  end

  def patch(client, %{id: id} = calendar) do
    path = "#{@base_url}/#{id}"

    client
    |> patch!(path, calendar, [@content_type])
    |> show_resp("Update calendar")
  end

  def delete(client, %{id: id}) do
    path = "#{@base_url}/#{id}"

    client
    |> delete!(path)
    |> show_resp("Delete calendar")
  end

  @doc """
  Only clear the primary calendar of an account
  """
  def clear(client, %{id: id} = calendar) do
    path = "#{@base_url}/#{id}/clear"

    client
    |> post!(path, calendar, [@content_type])
    |> show_resp("Clear all events in the primary calendar")
  end

end
