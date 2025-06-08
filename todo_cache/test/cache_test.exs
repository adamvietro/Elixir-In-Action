defmodule Todo.CacheTest do
  use ExUnit.Case

  test "server_process/2" do

    {:ok, cache} = Todo.Cache.start()

    bob_pid = Todo.Cache.server_process(cache, "bob")

    assert bob_pid = Todo.Cache.server_process(cache, "bob")
    assert bob_pid != Todo.Cache.server_process(cache, "alice")
  end

  test "to-do opperations" do

    {:ok, cache} = Todo.Cache.start()

    bob_pid = Todo.Cache.server_process(cache, "bob")

    Todo.Server.add_entry(bob_pid, %{date: ~D[2023-12-19], title: "dentist"})
    entries = Todo.Server.entries(bob_pid, ~D[2023-12-19])

    assert [%{date: ~D[2023-12-19], title: "dentist"}] = entries

  end
end
