defmodule TaskManager.Repo.Migrations.TaskTable do
  use Ecto.Migration

  def change do
    create table(:todo_task) do
      add :name, :string
      add :status, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
