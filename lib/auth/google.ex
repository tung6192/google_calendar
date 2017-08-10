defmodule Google do
  @moduledoc """
  An OAuth2 strategy for Google.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [strategy: Google,
     site: "https://accounts.google.com",
     authorize_url: "/o/oauth2/auth",
     token_url: "/o/oauth2/token"]
  end

  # Public API

  def client do
    Application.get_env(:google_calendar, Google)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    # Enable refresh token automatically & set up calendar authorization
    default_config = [
      scope: "https://www.googleapis.com/auth/calendar",
      access_type: "offline",
    ]
    params = Keyword.merge(default_config, params)

    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    params =
      :google_calendar
      |> Application.get_env(Google)
      |> Keyword.merge(params)
      |> Keyword.put(:response_type, nil)

    OAuth2.Client.get_token!(client(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
