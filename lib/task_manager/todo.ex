defmodule TaskManager.Todo do
  import Ecto.Query, warn: false
  alias TaskManager.Repo
  alias TaskManager.Todo.Task

  def list_tasks do
    Repo.all(Task)
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def delete_task(id) do
    task = Repo.get!(Task, id)
    Repo.delete(task)
  end

  def toogle_task(id) do
    task = Repo.get!(Task,  id)

    task
    |> Task.changeset(%{status: !task.status})
    |> Repo.update!()
  end
end
