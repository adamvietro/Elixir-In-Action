defmodule Todo.Database do
  # @poolsize 3
  @db_folder "./persist"

  # def start_link do
  #   File.mkdir_p!(@db_folder)

  #   children = Enum.map(1..@poolsize, &worker_spec/1)
  #   Supervisor.start_link(children, strategy: :one_for_one)
  # end # No longer needed as the child_spec states that you should invoke start_link from poolboy

  def child_spec(_) do
    File.mkdir_p!(@db_folder)

    :poolboy.child_spec(
      # Child ID
      __MODULE__,
      # Pool Options
      [
        name: {:local, __MODULE__},
        worker_module: Todo.DatabaseWorker,
        size: 3
      ],
      # Worker Args
      [@db_folder]
    )
  end

  def store(key, data) do
    # Asks pool for worker
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid -> # Perform the action on the worker.
        Todo.DatabaseWorker.store(worker_pid, key, data)
      end
    )
  end

  def get(key) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        Todo.DatabaseWorker.get(worker_pid, key)
      end
    )
  end

  # defp choose_worker(key) do
  #   :erlang.phash2(key, @poolsize) + 1
  # end
  # Don't need these 2 as the poolboy does the search and choosing itself.
  # defp worker_spec(worker_id) do
  #   default_worker_spec = {Todo.DatabaseWorker, {@db_folder, worker_id}}
  #   Supervisor.child_spec(default_worker_spec, id: worker_id)
  # end
end
