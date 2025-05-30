def read do
  IO.read(:stdio, :all)
  |> String.split("\n")
  |> Enum.map(fn x -> String.to_integer(x) end)
end
