defmodule TaskManagerWeb.TaskLive.Index do
  use TaskManagerWeb, :live_view

  @impl true
  def mount(_params, _sessions, socket) do
    dummy_tasks = [
      %{name: "Go to Mars", status: false},
      %{name: "By a rocket", status: true},
      %{name: "Clean your base", status: false}
    ]

    {:ok, assign(socket, :tasks, dummy_tasks)}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <.tasks_table tasks={@tasks} />
    """
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tasks =
      socket.assigns.tasks
      |> Enum.map(fn task ->
        if task.id == id do
          Map.update!(task, :status, fn status -> !status end)
        else
          task
        end
      end)

    {:noreply, assign(socket, :tasks, tasks)}
  end
end
