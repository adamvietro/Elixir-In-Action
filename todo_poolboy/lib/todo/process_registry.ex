defmodule Todo.ProcessRegistry do
  def start_link do
    Registry.start_link(keys: :unique, name: __MODULE__) # Starts a new Registry for the modules
  end

  def via_tuple(key) do
    {:via, Registry, {__MODULE__, key}} # will be used to name the workers via_tuple
  end

  def child_spec(_) do
    # this sets the names of the children it will be used in the other
    # modules to set the relationship
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    )
  end
end
