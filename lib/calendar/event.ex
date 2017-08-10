defmodule GoogleCalendar.Event do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/calendars"
  @content_type Application.get_env(:google_calendar, :content_type)

  def list(client, %{calendar_id: calendar_id}) do
    path = "#{@base_url}/#{calendar_id}/events"

    client
    |> get!(path)
    |> show_resp("Get event list")
  end

  def get(client, %{calendar_id: calendar_id, id: id}) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> get!(path)
    |> show_resp("Get event information")
  end

  def insert(client, %{calendar_id: calendar_id} = event) do
    path = "#{@base_url}/#{calendar_id}/events"

    client
    |> post!(path, event, [@content_type])
    |> show_resp("Insert event")
  end

  def update(client, %{calendar_id: calendar_id, id: id} = event) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> put!(path, event, [@content_type])
    |> show_resp("Update event")
  end

  def patch(client, %{calendar_id: calendar_id, id: id} = event) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> patch!(path, event, [@content_type])
    |> show_resp("Update event")
  end

  def delete(client, %{calendar_id: calendar_id, id: id}) do
    path = "#{@base_url}/#{calendar_id}/events/#{id}"

    client
    |> delete!(path)
    |> show_resp("Delete event")
  end
end