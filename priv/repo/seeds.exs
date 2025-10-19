# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskManager.Repo.insert!(%TaskManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskManager.Repo
alias TaskManager.Todo.Task

tasks = [
  %{name: "Groceries to Fruiterie", status: false},
  %{name: "Make you tax returns", status: false},
  %{name: "Call your mother", status: true},
  %{name: "Go on the moon", status: true},
  %{name: "Travel to Mars", status: false}
]

Enum.each(tasks, fn task ->
  %Task{}
  |> Task.changeset(task)
  |> Repo.insert!()
end)
