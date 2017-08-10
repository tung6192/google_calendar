defmodule GoogleCalendar.FreeBusy do
  import GoogleCalendar.Response
  import OAuth2.Client

  @base_url "#{Application.get_env(:google_calendar, :base_url)}/freeBusy"
  @content_type Application.get_env(:google_calendar, :content_type)

  @doc """
  Check list of optons in `https://developers.google.com/google-apps/calendar/v3/reference/freebusy`

      # Example data:
      data = %{
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
  def show(client, data, opts \\ [], headers \\ []) do
    headers = Keyword.merge(@content_type, headers)

    client
    |> post!(@base_url, data, headers, opts)
    |> show_resp("Show free time on calendar")
  end
end