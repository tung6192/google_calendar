defmodule GoogleCalendar.FreeBusy do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:oauth2_example, :base_url)}/freeBusy"
  @content_type Application.get_env(:oauth2_example, :content_type)

  @doc """
  Example data:
  calendar = %{
    id: calendar_id,
    timeMin: "2017-08-01T00:00:00Z",
    timeMax: "2017-08-09T00:00:00Z",
    timeZone: "UTC",
    items: [
      %{
        "id": calendar_id
      }
    ]
  }
  """
  def show(client, data) do
    client
    |> post!(@base_url, data, [@content_type])
    |> show_resp("Show free time on calendar")
  end
end