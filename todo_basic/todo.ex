defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  # def new(), do: %TodoList{}

  def new(entries \\ []) do
    Enum.reduce(entries, %TodoList{}, fn entry, todo_list ->
      add_entry(todo_list, entry)
    end)

    # entires, %TodoList{}, &add_entry(&2, &1)
    # Needs to be in this order as the lambda will pass the entry then the acc.
  end

  def add_entry(todo_list, entry) do
    # adds the id to the entry
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries =
      Map.put(
        todo_list.entries,
        todo_list.next_id,
        entry
      )

    # adds the new entry to the todo_list

    # updates the next id
    %TodoList{todo_list | entries: new_entries, next_id: todo_list.next_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  def entries(todo_list) do
    todo_list.entries
    |> Map.values()
  end

  def update_entries(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        IO.inspect("cant find")
        todo_list

      {:ok, _entry} ->
        updated_entries = Map.delete(todo_list.entries, entry_id)
        %TodoList{todo_list | entries: updated_entries}
    end
  end
end

defmodule TodoList.CsvImporter do
  def read(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn [date, title] ->
      %{date: Date.from_iso8601!(date), title: title}
    end)
    |> TodoList.new()
  end

  defimpl Collectable, for: TodoList do
    def into(original) do
      {original, &into_callback/2}
    end

    defp into_callback(todo_list, {:cont, entry}) do
      TodoList.add_entry(todo_list, entry)
    end

    defp into_callback(todo_list, :done), do: todo_list
    defp into_callback(_todo_list, :halt), do: :ok
  end
end

# TodoList.CsvImporter.read("todo.txt")
# |> IO.inspect(label: "final")
