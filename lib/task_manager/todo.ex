defmodule TaskManager.Todo do
  alias TaskManager.Repo
  alias TaskManager.Todo.Task

  def list_tasks() do
    Repo.all(Task)
  end
end
