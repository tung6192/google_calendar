defmodule GoogleCalendar.Response do
  def show_resp({:ok, resp}, action) do
    {:ok, "#{action} successfully", resp.body}
  end

  def show_resp({:error, resp}, _action) do
    case resp.status_code do
      code when code in 400..599 ->
        {:error, code, resp.body["error"]["message"]}
      code ->
        {:error, code, "Unhandled code, #{resp.body}"}
    end
  end
end