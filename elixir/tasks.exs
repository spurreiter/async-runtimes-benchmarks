# Tasks are a higher-level abstraction and they will include additional features
# for tracking responses.

defmodule Tasks do
  use Task

  def run_tasks do
    num_tasks =
      System.argv()
      |> List.first()
      |> String.to_integer()

    tasks =
      for _ <- 1..num_tasks do
        Task.async(fn ->
          :timer.sleep(10000)
        end)
      end

    Task.await_many(tasks, :infinity)
    IO.puts("All tasks completed")
  end
end

# Run the tasks with a specific number of parallel tasks
Tasks.run_tasks()
