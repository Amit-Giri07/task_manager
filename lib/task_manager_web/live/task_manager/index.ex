defmodule TaskManagerWeb.TaskLive.Index do
  use TaskManagerWeb, :live_view
  alias TaskManager.Todo
  alias TaskManager.Todo.Task

  @impl true
  def mount(_params, _sessions, socket) do
    tasks = Todo.list_tasks()

    {:ok,
     socket
     |> assign(:tasks, tasks)
     |> assign(:form, to_form(Todo.change_task(%Task{})))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.task_input form={@form} /> <.tasks_table tasks={@tasks} />
    """
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    Todo.delete_task(id)

    tasks =
      socket.assigns.tasks
      |> Enum.filter(fn task -> task.id != id end)

    {:noreply,
     socket
     |> assign(:tasks, tasks)
     |> assign(:form, to_form(Todo.change_task(%Task{})))}
  end

  @impl true
  def handle_event("save", %{"name" => task_name}, socket) do
    id =
      socket.assigns.tasks
      |> Enum.reduce(0, fn task, acc -> if task.id > acc, do: task.id, else: acc end)

    tasks = socket.assigns.tasks ++ [%{id: id + 1, task: task_name, status: false}]

    {:noreply,
     socket
     |> assign(:tasks, tasks)
     |> assign(:form, to_form(Todo.change_task(%Task{})))}
  end

  @impl true
  def handle_event("save", %{"task" => task}, socket) do
    {:ok, task} = Todo.create_task(task)
    tasks = socket.assigns.tasks ++ [task]

    {:noreply,
     socket
     |> assign(tasks: tasks)
     |> assign(:form, to_form(Todo.change_task(%Task{})))}
  end
end
