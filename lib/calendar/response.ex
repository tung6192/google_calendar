defmodule GoogleCalendar.Response do

  def show_resp(resp, action) do
    case resp.status_code do
      code when code in 200..209 ->
        {:ok, "#{action} successfully", resp.body}
      code when code in 400..599 ->
        {:error, code, resp.body["error"]["message"]}
      code ->
        {:error, code, "Unhandled code, #{resp.body}"}
    end
  end
end