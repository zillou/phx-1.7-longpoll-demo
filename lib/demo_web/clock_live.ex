defmodule DemoWeb.ClockLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <h2>It's <%= DateTime.to_iso8601(@date) %></h2>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 1000)

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    assign(socket, date: DateTime.utc_now())
  end
end
