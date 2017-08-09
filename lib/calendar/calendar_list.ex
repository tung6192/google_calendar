defmodule GoogleCalendar.CalendarList do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:oauth2_example, :base_url)}/users/me/calendarList"
  @content_type Application.get_env(:oauth2_example, :content_type)

  def list(client) do
    client
    |> get!(@base_url)
    |> show_resp("Get calendar list")
  end

  def get(client, %{id: id}) do
    path = "#{@base_url}/#{id}"

    client
    |> get!(path)
    |> show_resp("Get the calendar information")
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
end