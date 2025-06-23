defmodule Todo.DatabaseWorker do
  use GenServer

  def start_link(folder) do
    GenServer.start_link(
      __MODULE__,
      folder
    )
  end

  def store(worker_id, key, data) do
    GenServer.cast(worker_id, {:store, key, data})
  end

  def get(worker_id, key) do
    GenServer.call(worker_id, {:get, key})
  end

  @impl GenServer
  def init(folder) do
    IO.puts("Starting database worker.")
    {:ok, folder}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, folder) do
    folder
    |> file_name(key)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, folder}
  end

  @impl GenServer
  def handle_call({:get, key}, _, folder) do
    data =
      case File.read(file_name(folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, folder}
  end

  # defp via_tuple(worker_id) do
  #   Todo.ProcessRegistry.via_tuple({__MODULE__, worker_id})
  # end

  defp file_name(folder, key) do
    Path.join(folder, to_string(key))
  end
end
