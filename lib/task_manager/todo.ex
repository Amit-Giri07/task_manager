defmodule TaskManager.Todo do
  import Ecto.Query, warn: false
  alias TaskManager.Repo
  alias TaskManager.Todo.Task

  def list_tasks do
    Repo.all(Task)
  end

  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end

