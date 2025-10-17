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
    <div class="mt-11">
      <div class="text-xl grid-cols-[3fr_1fr_0.5fr] grid grid-cols-3 gap-2 pt-2 pb-2 text-left text-zinc-500">
        <div class="auto-cols-max">Task</div>

        <div>status</div>

        <div></div>
      </div>

      <div
        :for={task <- @tasks}
        id={["task-", task.id]}
        class="text-lg grid grid-cols-3 grid-cols-[3fr_1fr_0.5fr] gap-2 pt-2 pb-2 hover:bg-zinc-50 border-t"
        phx-click={JS.push("toggle", value: %{id: task.id})}
      >
        <div>{task.name}</div>

        <div>{task.status}</div>

        <div><.link phx-click={JS.push("delete", value: %{id: task.id})}>X</.link></div>
      </div>
    </div>
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
