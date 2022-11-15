defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: current_time())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-2xl">Your score: <%= @score %></h1>
    <h2 class="text-lg"><%= @message %></h2>
    <p>Current time: <%= @time %></p>
    <h2>
      <%= for n <- 1..10 do %>
        <a
          href="#"
          phx-click="guess"
          phx-value-number={n}
          class="hover:text-orange-500 hover:underline"
        >
          <%= n %>
        </a>
      <% end %>
    </h2>
    """
  end

  @impl true
  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again!"
    score = socket.assigns.score - 1

    {:noreply, assign(socket, message: message, score: score, time: current_time())}
  end

  defp current_time, do: Time.utc_now() |> to_string
end
