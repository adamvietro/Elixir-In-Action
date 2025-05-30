defmodule SmallData do
  alias ElixirLS.LanguageServer.Plugins.Ecto
  defstruct [:name, :phone_number, :cell_phone, :directions]

  import Ecto

  @types %{name: :string, phone_number: :string, cell_phone: :string, directions: :sting}

  def changeset(%SmallData{} = small_data, params) do
    {small_data, @types}
    |> Ecto.Changeset.cast(params, Map.keys(@types))
    |> Ecto.Changeset.validate_length(:name, min: 4, max: 20)
    |> Ecto.Changeset.validate_required(:name)
  end

  def new(params) do
    %SmallData{}
    |> changeset(params)
    |> Ecto.Changeset.apply_action(:update)
  end
end
